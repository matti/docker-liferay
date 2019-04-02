FROM mattipaksula/ubuntu-openjdk-liferay:18.04_11.0.2_7.1.2-ga3-20190107144105508

COPY --chown=liferay:liferay layers/app /app
ENTRYPOINT [ "/app/entrypoint.sh" ]
