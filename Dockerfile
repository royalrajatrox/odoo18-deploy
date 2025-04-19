FROM python:3.10

# Install dependencies
RUN apt update && apt install -y \
    git build-essential wget python3-dev \
    libxml2-dev libxslt1-dev zlib1g-dev \
    libsasl2-dev libldap2-dev libjpeg-dev \
    libpq-dev libffi-dev libtiff5-dev \
    libopenjp2-7-dev liblcms2-dev libwebp-dev \
    libharfbuzz-dev libfribidi-dev libxcb1-dev \
    libssl-dev libfreetype6-dev libpng-dev \
    wkhtmltopdf

# Set environment variables
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Create odoo user
RUN useradd -m -U -r -s /bin/bash odoo

# Switch to odoo user
USER odoo
WORKDIR /home/odoo

# Clone Odoo
RUN git clone --depth 1 --branch 18.0 https://github.com/odoo/odoo.git

# Create virtualenv & install Python requirements
WORKDIR /home/odoo/odoo
RUN pip install wheel && pip install -r requirements.txt

# Expose port
EXPOSE 8069

# Run Odoo
CMD ["python3", "odoo-bin", "--dev=all", "--db_host=DB_HOST", "--db_user=DB_USER", "--db_password=DB_PASSWORD"]
