FROM odoo:18.0

USER root

RUN apt update && apt install -y \
    wkhtmltopdf \
    libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev \
    libjpeg-dev libffi-dev libssl-dev \
    && apt clean

# Copy our custom config
COPY ./odoo.conf /etc/odoo/odoo.conf
RUN chown odoo:odoo /etc/odoo/odoo.conf

USER odoo

# (Optional) Copy custom addons later
# COPY --chown=odoo:odoo ./custom-addons /mnt/extra-addons

CMD ["odoo", "-i", "base", "-d", "odoo18_db", "--db_host=dpg-d01rio3e5dus73bgijq0-a", "--db_port=5432", "--db_user=odoo18_db_user", "--db_password=Atoo3a4y2hOXwaOo24WMpReYWvtEXU4O"]

