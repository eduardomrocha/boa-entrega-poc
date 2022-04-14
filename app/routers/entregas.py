from datetime import datetime

from app.database.database_session import get_db
from app.models import CentroDistribuicao, Entrega, StatusEntrega, Usuario
from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy.orm import Session

router = APIRouter()


@router.get("/entregas/{codigo_barras}")
async def get_entrega(
    codigo_barras: int = None, request: Request = None, db: Session = Depends(get_db)
):
    user_id = request.headers.get("user_id")
    usuario = db.query(Usuario).get(user_id)

    if not usuario:
        raise HTTPException(
            status_code=401, detail="Unauthorized",
        )

    if codigo_barras:
        entrega = (
            db.query(Entrega)
            .filter(
                Entrega.codigo_barras == codigo_barras,
                Entrega.id_empresa == usuario.id_empresa,
            )
            .first()
        )

        if entrega:
            return {
                "id": entrega.id,
                "destinatario": entrega.destinatario,
                "destino": entrega.destino,
                "codigo_barras": entrega.codigo_barras,
                "data_entrega": entrega.data_entrega,
                "valor_cobranca": entrega.valor_cobranca,
                "cte": entrega.cte,
                "volume": entrega.volume,
                "prazo_entrega": entrega.prazo_entrega,
                "centro_distribuicao_atual": entrega.centro_distribuicao_atual.name,
                "rota": {
                    "origem": entrega.rota.origem,
                    "destino": entrega.rota.destino,
                    "centros_distribuicao": entrega.rota.getNomeCentrosDistribuicao(),
                },
                "status_entrega": entrega.status_entrega.status,
                "empresa": entrega.empresa.nome,
                "tipo_cobranca": entrega.tipo_cobranca.tipo,
                "status_cobranca": entrega.status_cobranca.status,
            }

        else:
            return {"message": "Entrega não encontrada"}

    return


@router.get("/entregas")
async def entregas(
    data: str = None,
    centro_distribuicao: str = None,
    status: str = None,
    request: Request = None,
    db: Session = Depends(get_db),
):
    user_id = request.headers.get("user_id")
    usuario = db.query(Usuario).get(user_id)

    if not usuario:
        raise HTTPException(
            status_code=401, detail="Unauthorized",
        )

    query = db.query(Entrega)
    if data:
        query = query.filter(
            Entrega.data_entrega == datetime.strptime(data, "%d-%m-%Y").date()
        )
    if centro_distribuicao:
        query = query.filter(
            Entrega.id_centro_distribuicao_atual
            == db.query(CentroDistribuicao)
            .filter(CentroDistribuicao.name == centro_distribuicao)
            .first()
            .id
        )
    if status:
        query = query.filter(
            Entrega.id_status_entrega
            == db.query(StatusEntrega).filter(StatusEntrega.status == status).first().id
        )

    if usuario.permissao.permissao == "colaborador":
        query = query.all()
    else:
        query = query.filter(Entrega.id_empresa == usuario.id_empresa).all()

    entregas = []

    for entrega in query:
        entregas.append(
            {
                "id": entrega.id,
                "destinatario": entrega.destinatario,
                "destino": entrega.destino,
                "codigo_barras": entrega.codigo_barras,
                "data_entrega": entrega.data_entrega,
                "valor_cobranca": entrega.valor_cobranca,
                "cte": entrega.cte,
                "volume": entrega.volume,
                "prazo_entrega": entrega.prazo_entrega,
                "centro_distribuicao_atual": entrega.centro_distribuicao_atual.name,
                "rota": {
                    "origem": entrega.rota.origem,
                    "destino": entrega.rota.destino,
                    "centros_distribuicao": entrega.rota.getNomeCentrosDistribuicao(),
                },
                "status_entrega": entrega.status_entrega.status,
                "empresa": entrega.empresa.nome,
                "tipo_cobranca": entrega.tipo_cobranca.tipo,
                "status_cobranca": entrega.status_cobranca.status,
            }
        )

    return {
        "entregas": entregas,
    }
