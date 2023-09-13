use e_commerce_db;


create table orders
(
    order_id     int auto_increment
        primary key,
    created      date default (curdate()) null,
    total_amount float                    null,
    order_status bit  default b'0'        null
);

create table Product
(
    Product_id      char(5)      not null
        primary key,
    Category_name   varchar(100) not null,
    Price           float        null,
    Description     text         not null,
    Category_status bit          null
);


create table order_details
(
    order_id   int   not null,
    product_id char(5)  not null,
    price      float not null,
    quantity   int   not null,
    amount     float as ((price * quantity)),
    constraint order_id_fk
        foreign key (order_id) references orders (order_id),
    constraint product_id_fk
        foreign key (product_id) references Product (Product_id)
);

