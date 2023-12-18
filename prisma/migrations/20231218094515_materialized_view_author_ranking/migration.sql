-- Materialized View Author Ranking

CREATE MATERIALIZED VIEW author_ranking_materialized_view AS (
    SELECT
        "author_books"."author_id" AS "author_id",
        "authors"."name" AS "author_name",
        COUNT("author_books"."book_id") AS "book_count"
    FROM
        "author_books"
    LEFT JOIN "authors" ON "author_books"."author_id" = "authors"."id"
    GROUP BY
        "author_books"."author_id",
        "authors"."name"
    ORDER BY
        COUNT("author_books"."book_id") DESC
);

COMMENT ON MATERIALIZED VIEW author_ranking_materialized_view IS '著者ごとの書籍販売数ランキングのマテビュー';
COMMENT ON COLUMN author_ranking_materialized_view.author_id IS '著者ID';
COMMENT ON COLUMN author_ranking_materialized_view.author_name IS '著者名';
COMMENT ON COLUMN author_ranking_materialized_view.book_count IS '書籍販売数';