create table message (
   id varchar(255) not null,
    filename varchar(255),
    tag varchar(255),
    text varchar(2048) not null,
    user_id varchar(255),
    primary key (id)
);

create table user_role (
   user_id varchar(255) not null,
    roles varchar(255)
);

create table usr (
   id varchar(255) not null,
    activation_code varchar(255),
    active boolean not null,
    email varchar(255),
    password varchar(255) not null,
    username varchar(255) not null,
    primary key (id)
);

alter table if exists message
   add constraint message_user
   foreign key (user_id)
   references usr;

alter table if exists user_role
   add constraint ur_user
   foreign key (user_id)
   references usr;