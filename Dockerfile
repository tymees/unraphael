FROM python:3.12-slim

RUN pip install torch==2.3.1+cpu torchvision torchaudio 'numpy<2.0' --extra-index-url https://download.pytorch.org/whl/cpu && rm -rf /root/.cache
RUN apt-get update && apt-get install libgl1 libglib2.0-0 -y

WORKDIR /app

COPY pyproject.toml MANIFEST.in ./
COPY ./src ./src

RUN pip install .[dash] && rm -rf /root/.cache

EXPOSE 8501

ENTRYPOINT ["unraphael-dash", "--server.port=8501"]
CMD ["--server.address=0.0.0.0"]
