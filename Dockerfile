FROM devilbox/php-fpm:8.2-work

# Arguments defined in docker-compose.yml
ARG user
ARG NEW_UID
ARG NEW_GID
ARG TIMEZONE
ENV NEW_UID $NEW_UID
ENV NEW_GID $NEW_GID
ENV TIMEZONE $TIMEZONE

# Install system dependencies
RUN apt update && apt install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

USER $user