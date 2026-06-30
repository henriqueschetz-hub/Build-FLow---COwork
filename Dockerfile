FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY buildflow_webhook.py .
CMD ["python3", "buildflow_webhook.py"]
