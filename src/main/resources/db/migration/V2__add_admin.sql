insert into usr (id, username, password, active)
    values ('admin', 'admin', '123', true);

insert into user_role (user_id, roles)
    values ('admin', 'USER'), ('admin', 'ADMIN');