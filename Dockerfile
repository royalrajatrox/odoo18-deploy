FROM odoo:18.0

USER root

RUN apt update && apt install -y \
    wkhtmltopdf \
    libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev \
    libjpeg-dev libffi-dev libssl-dev \
    && apt clean

USER odoo

# (Optional) Copy custom addons folder
# COPY --chown=odoo:odoo ./custom-addons /mnt/extra-addons

CMD ["odoo", "-c", "/etc/odoo/odoo.conf", "--db_host=${DB_HOST}", "--db_port=${DB_PORT}", "--db_user=${DB_USER}", "--db_password=${DB_PASSWORD}", "--db_name=${DB_NAME}", "--dev=all"]
