FROM python:3.12-slim

WORKDIR /app

RUN python -m pip install --upgrade pip

COPY requirements.txt .

RUN pip install  --no-cache-dir -r requirements.txt

# running as non-root user and giving the ownership models.py is in /app and user cant see it otherwise
RUN useradd -m appuser
RUN chown -R appuser:appuser /app
USER appuser

COPY  . .

EXPOSE 5000

CMD ["python","app.py"]

#docker tag dockerleena778/food-delivery:v1.0 food-delivery-app:v1.0
# The above command must include the tag of the SOURCE  
#must include dockerleena778<imagename>:tag