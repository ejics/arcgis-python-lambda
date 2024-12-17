import logging
from arcgis.gis import GIS

logging.getLogger().setLevel(logging.INFO)
logger = logging.getLogger(__name__)

def lambda_handler(event, context):

    logger.info("start arcgis api for python.")
    gis = GIS("https://https://www.arcgis.com", "[username]", "[password]")
    logger.info("end.")