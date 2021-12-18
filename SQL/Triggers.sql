-- Function that adds 2 to the stock of a book when it falls to 2 or below
create function update_stock()
returns trigger
language plpgsql
as $$
begin
	if (new.stock <= 2)
	then
		new.stock = new.stock + 2;
	end if;
	return new;
end;
$$;

-- Trigger that calls the update_stock function to check book stock after every update on the book table
create trigger restock_book
after update on book
for each row
execute procedure update_stock();