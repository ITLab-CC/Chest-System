"""added cupboard

Revision ID: ced2f5684ebb
Revises: babff3249ab1
Create Date: 2024-06-27 08:48:30.841176

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'ced2f5684ebb'
down_revision: Union[str, None] = 'babff3249ab1'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('cupboard',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('cupboard_name', sa.String(), nullable=False),
    sa.Column('location', sa.String(), nullable=False),
    sa.PrimaryKeyConstraint('id')
    )
    op.add_column('kiste', sa.Column('cupboard_id', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'kiste', 'cupboard', ['cupboard_id'], ['id'])
    op.drop_column('kiste', 'location')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('kiste', sa.Column('location', sa.VARCHAR(), autoincrement=False, nullable=False))
    op.drop_constraint(None, 'kiste', type_='foreignkey')
    op.drop_column('kiste', 'cupboard_id')
    op.drop_table('cupboard')
    # ### end Alembic commands ###
