import logging

import uvicorn
from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI, Request, status
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from app.api.v1.router import router as api_v1_router
from app.api.v2.router import router as api_v2_router

logging.basicConfig(format='%(asctime)s:%(levelname)s:%(message)s', level=logging.DEBUG)  # NOSONAR



tags_metadata = [
    {
        'name': 'chest',
        'description': 'Operations with chests. ',
    },
    {
        'name': 'item',
        'description': 'Operations  with items.',
    },
]

app = FastAPI(openapi_tags=tags_metadata,
              openapi_url='/api/openapi.json',
                docs_url='/api/docs',
                redoc_url='/api/redoc')

origins = [
    'http://localhost',
    'http://localhost:8000',
    'http://localhost:3000',
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
    expose_headers=[],
)

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
	exc_str = f'{exc}'.replace('\n', ' ').replace('   ', ' ')
	logging.error(f"{request}: {exc_str}")
	content = {'status_code': 10422, 'message': exc_str, 'data': None}
	return JSONResponse(content=content, status_code=status.HTTP_422_UNPROCESSABLE_ENTITY)

# This function routes to version 1 of the REST API /v1/..
app.include_router(
    api_v1_router,
    prefix='/api/v1',
)

# This function routes to version 2 of the REST API /v2/..
app.include_router(
    api_v2_router,
    prefix='/api/v2',
)

if __name__ == '__main__':
    logging.info('App is up and running')
    uvicorn.run('app.main:app', host='0.0.0.0', port=8000)
