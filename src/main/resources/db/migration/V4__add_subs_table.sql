create table user_subs(
    chanel_id varchar(255) not null references usr,
    sub_id varchar(255) not null references usr,
    primary key (chanel_id, sub_id)
)