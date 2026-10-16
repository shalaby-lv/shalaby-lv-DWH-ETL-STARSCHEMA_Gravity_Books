-- FOR CUSTOMER
SELECT CUST.customer_id,CUST.first_name,CUST.last_name,CUST.email
,ADDR.street_number,ADDR.city,ADDR.street_name,CON.country_name,
ADDR_STAT.address_status
FROM
customer CUST 
LEFT OUTER JOIN 
customer_address CUST_ADDR 
ON CUST.customer_id = CUST_ADDR.customer_id
LEFT OUTER JOIN
address ADDR
ON ADDR.address_id = CUST_ADDR.address_id
LEFT OUTER JOIN
country CON
ON ADDR.country_id = CON.country_id
LEFT OUTER JOIN address_status ADDR_STAT
ON CUST_ADDR.status_id = ADDR_STAT.status_id

-- FOR BOOK
SELECT BOOK.book_id,BOOK.title,BOOK.isbn13,BOOK.num_pages,BOOK.publication_date
,BOOK_LAN.language_code,BOOK_LAN.language_name,PUB.publisher_name,author.author_name
FROM
book 
LEFT OUTER JOIN 
book_language BOOK_LAN
ON BOOK.language_id = BOOK_LAN.language_id
LEFT OUTER JOIN 
publisher PUB
ON BOOK.publisher_id = PUB.publisher_id
LEFT OUTER JOIN 
book_author 
ON BOOK.book_id = book_author.book_id 
LEFT OUTER JOIN
author 
ON book_author.author_id = author.author_id

-- FOR FACT
SELECT CUST_OR.customer_id,CUST_OR.order_date,ORD_L.price,ORD_L.book_id,SHI_ME.cost
FROM
cust_order CUST_OR
JOIN
order_line ORD_L
ON CUST_OR.order_id = ORD_L.order_id
JOIN
shipping_method SHI_ME
ON CUST_OR.shipping_method_id = SHI_ME.method_id