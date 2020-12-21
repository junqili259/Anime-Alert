FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7

COPY ./api .

COPY ./api/requirements.txt ./

RUN pip install -r requirements.txt

CMD
