-- CreateTable
CREATE TABLE "products" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "books" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "published_on" TIMESTAMP(3) NOT NULL,
    "price" INTEGER NOT NULL,
    "subtitle" TEXT NOT NULL,
    "publisher_id" TEXT NOT NULL,

    CONSTRAINT "books_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "publishers" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "publishers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "authors" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "authors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "author_books" (
    "author_id" TEXT NOT NULL,
    "book_id" TEXT NOT NULL,

    CONSTRAINT "author_books_pkey" PRIMARY KEY ("author_id","book_id")
);

-- CreateTable
CREATE TABLE "book_images" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "book_id" TEXT NOT NULL,

    CONSTRAINT "book_images_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customers" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "customers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_items" (
    "id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "book_id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,

    CONSTRAINT "order_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shipping_addresses" (
    "id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "postal_code" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "tel" TEXT NOT NULL,

    CONSTRAINT "shipping_addresses_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "products_code_key" ON "products"("code");

-- AddForeignKey
ALTER TABLE "books" ADD CONSTRAINT "books_publisher_id_fkey" FOREIGN KEY ("publisher_id") REFERENCES "publishers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "author_books" ADD CONSTRAINT "author_books_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "authors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "author_books" ADD CONSTRAINT "author_books_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_images" ADD CONSTRAINT "book_images_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_items" ADD CONSTRAINT "order_items_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_items" ADD CONSTRAINT "order_items_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shipping_addresses" ADD CONSTRAINT "shipping_addresses_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

COMMENT ON TABLE products IS '商品：社内全体で管理されている商品コードを格納';
COMMENT ON COLUMN products.code IS '商品コード；社内全体で管理されている';

COMMENT ON TABLE books IS '書籍';
COMMENT ON COLUMN books.title IS '書籍名';
COMMENT ON COLUMN books.published_on IS '出版日';
COMMENT ON COLUMN books.price IS '価格';
COMMENT ON COLUMN books.subtitle IS 'サブタイトル';
COMMENT ON COLUMN books.publisher_id IS '出版社ID';

COMMENT ON TABLE publishers IS '出版社（管理者用アプリからのみ作成される）';
COMMENT ON COLUMN publishers.name IS '出版社名';

COMMENT ON TABLE authors IS '著者（書籍とは別に作成可能）';
COMMENT ON COLUMN authors.name IS '著者名';

COMMENT ON TABLE author_books IS '著者と書籍の中間テーブル';
COMMENT ON COLUMN author_books.author_id IS '著者ID';
COMMENT ON COLUMN author_books.book_id IS '書籍ID';

COMMENT ON TABLE book_images IS '書籍画像';
COMMENT ON COLUMN book_images.url IS '画像URL';
COMMENT ON COLUMN book_images.book_id IS '書籍ID';

COMMENT ON TABLE customers IS '顧客';
COMMENT ON COLUMN customers.name IS '顧客名';
COMMENT ON COLUMN customers.email IS 'メールアドレス';
COMMENT ON COLUMN customers.password IS 'パスワード（暗号化済み）';

COMMENT ON TABLE orders IS '注文：注文の確定ごとに作成される。請求処理は注文の重複がないかどうか確認されてから行われるため、必ずしも対応関係ではない。';
COMMENT ON COLUMN orders.customer_id IS '顧客ID';

COMMENT ON TABLE order_items IS '注文明細';
COMMENT ON COLUMN order_items.order_id IS '注文ID';
COMMENT ON COLUMN order_items.book_id IS '書籍ID';
COMMENT ON COLUMN order_items.quantity IS '数量';
COMMENT ON COLUMN order_items.price IS '価格';

COMMENT ON TABLE shipping_addresses IS '配送先';
COMMENT ON COLUMN shipping_addresses.customer_id IS '顧客ID';
COMMENT ON COLUMN shipping_addresses.name IS '名前';
COMMENT ON COLUMN shipping_addresses.postal_code IS '郵便番号';
COMMENT ON COLUMN shipping_addresses.address IS '住所';
COMMENT ON COLUMN shipping_addresses.tel IS '電話番号';

