FROM python:3.9

RUN apt update && apt install -y \
    git build-essential wget python3-dev \
    libxml2-dev libxslt1-dev zlib1g-dev \
    libsasl2-dev libldap2-dev libjpeg-dev \
    libpq-dev libffi-dev libtiff5-dev \
    libopenjp2-7-dev liblcms2-dev libwebp-dev \
    libharfbuzz-dev libfribidi-dev libxcb1-dev \
    libssl-dev libfreetype6-dev libpng-dev \
    wkhtmltopdf

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN useradd -m -U -r -s /bin/bash odoo

USER odoo
WORKDIR /home/odoo

RUN git clone --depth 1 --branch 18.0 https://github.com/odoo/odoo.git

WORKDIR /home/odoo/odoo
RUN pip install wheel && pip install -r requirements.txt

EXPOSE 8069

CMD ["python3", "odoo-bin", "--dev=all", "--db_host=${DB_HOST}", "--db_port=${DB_PORT}", "--db_user=${DB_USER}", "--db_password=${DB_PASSWORD}", "--db_name=${DB_NAME}"]

