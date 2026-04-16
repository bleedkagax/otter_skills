/**
 * ScrollyEngine: Micro-framework for Scrollytelling visualizations
 * Powered by Scrollama for robust scroll detection
 * Version: 3.0 (Scrollama Integration)
 */
class ScrollyEngine {
    constructor(config) {
        this.steps = config.steps;
        this.drawFn = config.drawFn;
        this.onInteractive = config.onInteractive;

        // State Management
        this.currentState = { ...this.steps[0].params };
        this.targetState = { ...this.steps[0].params };
        this.currentIndex = 0;
        this.currentProgress = 0; // 0.0 to 1.0 within current step

        // AutoPlay Configuration
        this.isAutoPlaying = true;
        this.autoPlayTimer = null;
        this.isProgrammaticScroll = false; // Lock to distinguish auto-scroll from user-scroll

        // Canvas Setup
        this.canvas = document.getElementById('vis-canvas');
        this.ctx = this.canvas.getContext('2d');

        // Initialization
        this.initDOM();
        this.resizeCanvas();
        this.startAnimationLoop(); // Keep loop for parameter lerping (smooth transitions)
        
        // Initialize Scrollama
        this.scroller = scrollama();
        this.initScrollama();

        // Start AutoPlay Sequence
        setTimeout(() => this.startAutoPlay(), 1500);

        // Global Event Listeners
        window.addEventListener('resize', () => {
            this.resizeCanvas();
            this.scroller.resize();
        });
        
        // Manual Scroll Detection (Interrupt AutoPlay)
        window.addEventListener('scroll', () => {
            if (!this.isProgrammaticScroll && this.isAutoPlaying) {
                // Detected MANUAL scroll interaction
                this.stopAutoPlay();
            }
        });
    }

    initScrollama() {
        this.scroller
            .setup({
                step: '.step-card',
                offset: 0.5, // Trigger when element hits center of screen
                progress: true, // Enable precise progress tracking
                debug: false
            })
            .onStepEnter(response => {
                // Update Logic: Driven by Scroll position
                this.currentIndex = response.index;
                this.targetState = { ...this.steps[response.index].params };
                
                this.updateStepHighlights();
                
                // Trigger hooks
                this.handleStepEnter(response.index);
            })
            .onStepProgress(response => {
                this.currentProgress = response.progress;
                // We don't auto-update params here to avoid conflict with lerp,
                // but we expose 'progress' to the draw loop.
            });
    }

    handleStepEnter(index) {
        // Execute callbacks
        const step = this.steps[index];
        if (step.onEnter && typeof step.onEnter === 'function') {
            step.onEnter(this);
        }

        // Interactive Step Handling
        if (step.isInteractive) {
            this.stopAutoPlay(); // Force stop on interactive steps
            if (this.onInteractive) {
                this.onInteractive(this);
            }
        }

        // MathJax Refresh
        if (window.MathJax && window.MathJax.typesetPromise) {
            // Debounce MathJax to avoid performance hits
            if (this._mjTimer) clearTimeout(this._mjTimer);
            this._mjTimer = setTimeout(() => MathJax.typesetPromise(), 100);
        }

        // Check for End of AutoPlay
        if (this.isAutoPlaying && index === this.steps.length - 1) {
            // Reached the end
            this.stopAutoPlay();
        }
    }

    // =========================================
    // Auto-Play Logic (Simulate User Scroll)
    // =========================================

    startAutoPlay() {
        this.isAutoPlaying = true;
        this.updatePlayButton();
        this.scheduleNextScroll();
    }

    stopAutoPlay() {
        this.isAutoPlaying = false;
        if (this.autoPlayTimer) clearTimeout(this.autoPlayTimer);
        this.updatePlayButton();
    }

    toggleAutoPlay() {
        if (this.isAutoPlaying) {
            this.stopAutoPlay();
        } else {
            // If at the end, restart
            if (this.currentIndex >= this.steps.length - 1) {
                this.scrollToIndex(0);
                // Wait for scroll to finish before restarting logic
                setTimeout(() => this.startAutoPlay(), 1000);
            } else {
                this.startAutoPlay();
            }
        }
    }

    scheduleNextScroll() {
        if (!this.isAutoPlaying) return;

        // Determine duration based on content length (reading speed heuristic)
        // Average reading speed: 300-500 chars/min -> ~150ms/char
        // Math content requires more cognitive load, so we use a generous buffer.
        // Base: 3000ms (2s) min for short text
        // Cap: 5000ms (5s) max to prevent boredom
        // Rate: 40ms per character (faster reading pace)
        const currentStep = this.steps[this.currentIndex];
        // Strip HTML tags for accurate text length calculation
        const textContent = currentStep.content.replace(/<[^>]*>/g, '');
        const textLen = textContent.length;
        
        const delay = Math.min(5000, Math.max(3000, textLen * 40));

        this.autoPlayTimer = setTimeout(() => {
            if (!this.isAutoPlaying) return;

            const nextIndex = this.currentIndex + 1;
            if (nextIndex < this.steps.length) {
                this.scrollToIndex(nextIndex);
                this.scheduleNextScroll(); // Chain the next one
            } else {
                this.stopAutoPlay();
            }
        }, delay);
    }

    scrollToIndex(index) {
        this.isProgrammaticScroll = true;
        
        const el = document.querySelectorAll('.step-card')[index];
        if (el) {
            el.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }

        // Unlock after scroll animation (approx 1s)
        setTimeout(() => {
            this.isProgrammaticScroll = false;
        }, 1000);
    }

    // =========================================
    // Rendering & DOM
    // =========================================

    updateStepHighlights() {
        document.querySelectorAll('.step-card').forEach((card, i) => {
            const isCurrent = i === this.currentIndex;
            // Visual state managed via Tailwind classes
            if (isCurrent) {
                card.classList.remove('opacity-60', 'scale-95', 'border-slate-200', 'hover:bg-slate-50');
                card.classList.add('border-blue-600', 'bg-blue-50', 'text-slate-900', 'shadow-lg', 'scale-105');
            } else {
                card.classList.add('opacity-60', 'scale-95', 'border-slate-200', 'hover:bg-slate-50');
                card.classList.remove('border-blue-600', 'bg-blue-50', 'text-slate-900', 'shadow-lg', 'scale-105');
            }
        });
    }

    updatePlayButton() {
        const btn = document.getElementById('autoplay-btn');
        if (!btn) return;
        
        if (this.isAutoPlaying) {
            btn.innerHTML = '<span>⏸️</span> <span class="ml-2">自动播放中</span>';
            btn.classList.add('animate-pulse'); // Visual cue
        } else {
            btn.innerHTML = '<span>▶️</span> <span class="ml-2">手动模式 (点击重播)</span>';
            btn.classList.remove('animate-pulse');
        }
    }

    startAnimationLoop() {
        const animate = () => {
            // 1. Parameter Interpolation (Lerp)
            for (let key in this.targetState) {
                if (typeof this.currentState[key] === 'number') {
                    const diff = this.targetState[key] - this.currentState[key];
                    if (Math.abs(diff) > 0.001) {
                        this.currentState[key] += diff * 0.08; // Smooth factor
                    } else {
                        this.currentState[key] = this.targetState[key];
                    }
                } else {
                    this.currentState[key] = this.targetState[key]; // Boolean/String snap
                }
            }

            // 2. Draw Frame
            // Pass 'currentProgress' to allow precise animations inside the step
            this.drawFn(
                this.ctx, 
                this.currentState, 
                this.canvas.width, 
                this.canvas.height,
                this.currentProgress
            );

            requestAnimationFrame(animate);
        };
        animate();
    }

    resizeCanvas() {
        const parent = this.canvas.parentElement;
        if (parent) {
            this.canvas.width = parent.clientWidth;
            this.canvas.height = parent.clientHeight;
        }
    }

    initDOM() {
        const container = document.getElementById('step-container');
        container.innerHTML = ''; // Clear fallback content

        // Add Header
        const header = document.createElement('div');
        header.className = "mb-10 px-2";
        header.innerHTML = `<h1 class="text-3xl font-bold text-slate-800 tracking-tight mb-2">交互演示</h1>`;
        container.appendChild(header);

        // Render Steps
        this.steps.forEach((step, i) => {
            const card = document.createElement('div');
            card.className = 'step-card p-6 mb-4 rounded-xl border-l-4 cursor-pointer transition-all duration-500 ease-out border-slate-200 bg-white/90 backdrop-blur opacity-60 scale-95';
            card.dataset.stepId = step.id;
            
            card.innerHTML = `
                <h3 class="text-xl font-bold text-slate-800 mb-3">${step.title}</h3>
                <div class="text-slate-600 leading-relaxed space-y-3 font-sans">${step.content}</div>
            `;
            
            // Manual Click to Jump
            card.onclick = () => {
                this.stopAutoPlay();
                this.scrollToIndex(i);
            };

            container.appendChild(card);
        });

        // Add Spacer at bottom to allow last step to scroll to center
        const spacer = document.createElement('div');
        spacer.style.height = '50vh';
        container.appendChild(spacer);

        // Play Button Logic
        const playBtn = document.getElementById('autoplay-btn');
        if (playBtn) {
            playBtn.onclick = () => this.toggleAutoPlay();
        }
    }
    
    // Helper: Linear Interpolation
    lerp(start, end, t) {
        return start * (1 - t) + end * t;
    }
}