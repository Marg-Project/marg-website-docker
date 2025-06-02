FROM ubuntu:22.04
# Start with Ubuntu 22

USER root

# Do the apt installation also install git
RUN apt-get update && && apt-get install -y --no-install-recommends \
    python3.8 \
    python3.8-dev \
    python3.8-venv \
    python3-pip \
    make software-properties-common \
    curl \
    gcc \
    build-essential \
    mime-support \
    libgdal-dev \
    dos2unix \
    nano
RUN apt-get update --fix-missing && apt-get install -y git


# Install the postgres client
RUN apt-get update
RUN apt-get install -y postgresql-client-14

FROM python:3.8

# set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set up a virual environment to use for all later commands.
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --upgrade pip

# Set working directory
WORKDIR /app

# Install git and dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    libssl-dev

# Clone the project from GitHub
RUN git clone https://github.com/Marg-Project/marg-website.git /app

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY ./settings.py /app/Marg/Marg/settings.py

WORKDIR /app/Marg

# Collect static files (optional)
RUN python manage.py collectstatic

# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "Marg.wsgi:application"]

EXPOSE 8000