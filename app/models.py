from sqlalchemy import (BigInteger, Boolean, Column, DateTime, ForeignKey, Integer,
                        Numeric, String)
from sqlalchemy.orm import backref, relationship

from app.database.modelbase import Base


class Permissao(Base):
    __tablename__ = "permissao"
    id = Column(Integer, primary_key=True, autoincrement=True)
    permissao = Column(String(255))
    usuarios = relationship("Usuario", backref="permissao")


class Usuario(Base):
    __tablename__ = "usuario"
    id = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String(255))
    email = Column(String(255))
    id_permissao = Column(Integer, ForeignKey("permissao.id"))
    id_empresa = Column(Integer, ForeignKey("empresa.id"))


class Empresa(Base):
    __tablename__ = "empresa"
    id = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String(255))
    parceira = Column(Boolean)
    entregas = relationship("Entrega", backref="empresa")
    usuarios = relationship("Usuario", backref="empresa")


class CentroDistribuicao(Base):
    __tablename__ = "centro_distribuicao"
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(255))
    localizacao = Column(String(255))
    rotas = relationship("Rota", secondary="no_rota")


class Rota(Base):
    __tablename__ = "rota"
    id = Column(Integer, primary_key=True, autoincrement=True)
    origem = Column(String(255))
    destino = Column(String(255))
    prazo_entrega = Column(Integer)
    centros_distribuicao = relationship(
        "CentroDistribuicao", secondary="no_rota", overlaps="rotas"
    )

    def getNomeCentrosDistribuicao(self):
        return [centro.name for centro in self.centros_distribuicao]


class NoRota(Base):
    __tablename__ = "no_rota"
    id_centro_distribuicao = Column(
        Integer, ForeignKey("centro_distribuicao.id"), primary_key=True
    )
    id_rota = Column(Integer, ForeignKey("rota.id"), primary_key=True)


class Entrega(Base):
    __tablename__ = "entrega"
    id = Column(Integer, primary_key=True, autoincrement=True)
    destinatario = Column(String(255))
    destino = Column(String(255))
    codigo_barras = Column(BigInteger)
    data_entrega = Column(DateTime)
    valor_cobranca = Column(Numeric)
    cte = Column(String(255))
    volume = Column(Numeric)
    prazo_entrega = Column(Integer)
    id_centro_distribuicao_atual = Column(Integer, ForeignKey("centro_distribuicao.id"))
    id_rota = Column(Integer, ForeignKey("rota.id"))
    id_status_entrega = Column(Integer, ForeignKey("status_entrega.id"))
    id_empresa = Column(Integer, ForeignKey("empresa.id"))
    id_tipo_cobranca = Column(Integer, ForeignKey("tipo_cobranca.id"))
    id_status_cobranca = Column(Integer, ForeignKey("status_cobranca.id"))
    centro_distribuicao_atual = relationship("CentroDistribuicao", backref="entrega")
    rota = relationship("Rota", backref="entrega")
    status_entrega = relationship("StatusEntrega", backref="entrega")
    tipo_cobranca = relationship("TipoCobranca", backref="entrega")
    status_cobranca = relationship("StatusCobranca", backref="entrega")


class StatusCobranca(Base):
    __tablename__ = "status_cobranca"
    id = Column(Integer, primary_key=True, autoincrement=True)
    status = Column(String(255))


class StatusEntrega(Base):
    __tablename__ = "status_entrega"
    id = Column(Integer, primary_key=True, autoincrement=True)
    status = Column(String(255))


class TipoCobranca(Base):
    __tablename__ = "tipo_cobranca"
    id = Column(Integer, primary_key=True, autoincrement=True)
    tipo = Column(String(255))
