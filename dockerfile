FROM blang/latex:ctanbasic

LABEL maintainer="your@email.com"
LABEL description="Custom LaTeX image based on blang/latex:ctanbasic with extra packages"

# Update package list and install required LaTeX packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-lang-english \
    texlive-bibtex-extra \
    texlive-science \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /data

# Default command
CMD ["pdflatex"]