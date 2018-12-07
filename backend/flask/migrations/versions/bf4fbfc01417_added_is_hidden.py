"""Added is_hidden

Revision ID: bf4fbfc01417
Revises: bd9d395592c6
Create Date: 2018-12-06 16:45:20.818077

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'bf4fbfc01417'
down_revision = 'bd9d395592c6'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('reddit_meme', sa.Column('is_hidden', sa.Boolean(), nullable=True))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('reddit_meme', 'is_hidden')
    # ### end Alembic commands ###