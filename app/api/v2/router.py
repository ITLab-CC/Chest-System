from fastapi import APIRouter

from app.api.v2.endpoints.chest.router import router as chest_router
from app.api.v2.endpoints.item.router import router as item_router
from app.api.v2.endpoints.cupboard.router import router as cupboard_router


router = APIRouter()

router.include_router(chest_router, prefix='/chests')
router.include_router(item_router, prefix='/items')
router.include_router(cupboard_router, prefix='/cupboards')
