# Use NVIDIA CUDA base image for GPU support
FROM nvidia/cuda:13.1.0-devel-ubuntu24.04

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    DEBIAN_FRONTEND=noninteractive \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    GRADIO_SERVER_NAME="0.0.0.0"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy local files
COPY . .

# Install Python requirements
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose the Web UI port
EXPOSE 7860

# Default command to run the Integrated Web UI
CMD ["python3", "app.py", "--enable-v1", "--enable-v2"]

# Build:
# docker build -t seed-vc .

# Run
# docker run -it --gpus all -p 7860:7860 seed-vc