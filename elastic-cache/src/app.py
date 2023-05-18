from redis import Redis
import json
import logging
import os

logger = logging.getLogger(__name__)
primary_endpoint_address = os.getenv('PRIMARY_ENDPOINT_ADDRESS')
reader_endpoint_address = os.getenv('READER_ENDPOINT_ADDRESS')
redis_port = 6379

def put_in_cache(event, context):
    try:
        primary_redis = Redis(host=primary_endpoint_address, port=redis_port)
        reader_redis = Redis(host=reader_endpoint_address, port=redis_port)
        logging.info('#Starting redis connection')
        payload = json.loads(event['body'])
        message_body = payload['message']
        _key = message_body['key']
        _value = message_body['value']
        _ttl = message_body['ttl']
        put_response = primary_redis.set(_key, _value, _ttl)
        logger.info(
            "Successfully stored message in cash %s.", _key, _value)
    except Exception as ex:
        logger.exception("An error occurred: %s", ex)
        return {
            "body": json.dumps({
                "message": f"{ex}"
            }),
        }
    else:
        del primary_redis
        return {
            "body": json.dumps({
                "message": f"{put_response}"
            }),
        }


def get_from_cache(event, context):
    try:
        logging.info('#Starting redis connection')
        primary_redis = Redis(host=primary_endpoint_address, port=redis_port)
        reader_redis = Redis(host=reader_endpoint_address, port=redis_port)
        if Redis.ping():
            logging.info("Connected to Redis")
        _key = event['queryStringParameters']['key']
        print(f'The value of _key is: {_key}')
        _value = event['queryStringParameters']['value']
        print(f'The value of _value is: {_value}')
        _ttl = event['queryStringParameters']['ttl']
        print(f'The value of _ttl is: {_ttl}')
        cache_response = reader_redis.get(_key).decode()
        ttl_response = reader_redis.ttl(_key)
        reset_response = primary_redis.expire(_key, _ttl)
        get_response = {
            "Cached value is": cache_response,
            "TTL value is": ttl_response,
            "TTL reset value is": reset_response}
        logger.info(
            "Successfully stored message in cash %s.", _key, _value)
    except Exception as ex:
        logger.exception("An error occurred: %s", ex)
        return {
            "body": json.dumps({
                "message": f"{ex}"
            }),
        }
    else:
        del reader_redis
        return {
            "body": json.dumps({
                "message": f"{get_response}"
            }),
        }
