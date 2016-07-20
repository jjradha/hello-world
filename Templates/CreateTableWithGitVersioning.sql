﻿use <DbName,,>
go
-- select * from <schemaName,,dbo>.<tableName,,>;

if exists ( select * 
			from sys.objects 
			where [object_id] = object_id( N'<schemaName,,dbo>.<tableName,,>' ) 
				and [type] in ( N'U' ) )
begin
	set nocount on;
	
	select * 
	into #dropNpop_<schemaName,,dbo><tableName,,>
	from <schemaName,,dbo>.<tableName,,>;

	drop table <schemaName,,dbo>.<tableName,,>;
	print 'dropped table <schemaName,,dbo>.<tableName,,> SUCCESSFULLY! At time ' + convert( varchar, getdate(), 126 );
end;
go

create table <schemaName,,dbo>.<tableName,,>
(
	<tableName,,>Id int not null identity,
	<tableName,,>Name varchar( 100 ) not null constraint chk_<tableName,,>_NameIsNotEmpty check ( datalength( ltrim( rtrim( <tableName,,>Name ) ) ) > 0 ),
	
	InsertBy varchar( 100 ) not null constraint df_<tableName,,>_InsertBy default replace( system_user, 'GRCORP\', '' ),
	InsertDT datetime not null constraint df_<tableName,,>_InsertDT default getdate(),
	LastUpdateBy varchar( 100 ) not null constraint df_<tableName,,>_LastUpdateBy default replace( system_user, 'GRCORP\', '' ),
	LastUpdateDT datetime not null constraint df_<tableName,,>_LastUpdateDT default getdate(),
	Revision int not null constraint df_<tableName,,>_Revision default 0,
	constraint pk_<tableName,,>_Id primary key ( <tableName,,>Id )
);

go

create unique nonclustered index ak_<tableName,,>_Name on <schemaName,,dbo>.<tableName,,> ( <tableName,,>Name );

go

if object_id( N'tempdb..#dropNpop_<schemaName,,dbo><tableName,,>' ) is not null
begin

	<HasId,-- ( no ),-- >set identity_insert <schemaName,,dbo>.<tableName,,> on;

	declare @sql nvarchar( max ) = ''; 

	select @sql += 
		quotename( c1.name ) + ',' 
	from sys.columns c1
	join tempdb.sys.columns c2 on 
		c2.name = c1.name and
		c2.[object_id] = object_id( N'tempdb..#dropNpop_<schemaName,,dbo><tableName,,>' )
	where c1.[object_id] = object_id( N'<schemaName,,dbo>.<tableName,,>' ) and 
		c1.is_computed = 0;

	set @sql = left( @sql, len( @sql ) - 1 );
		
	set @sql = 
	'insert <schemaName,,dbo>.<tableName,,> 
		(' + @sql + ') 
	select 
		' + @sql + '
	from #dropNpop_<schemaName,,dbo><tableName,,>;';

	exec sp_executesql @sql;

	<HasId,-- ( no ),-- > set identity_insert <schemaName,,dbo>.<tableName,,> off;

end;
	
GO

IF EXISTS ( select * 
			from sys.objects 
			where [object_id] = object_id( N'<schemaName,,dbo>.<tableName,,>' ) and 
				[type] in ( N'U' ) )
begin
	print 'created table <schemaName,,dbo>.<tableName,,> SUCCESSFULLY! At time ' + convert( varchar, getdate(), 126 );
END;

go

create trigger tr_<tableName,,>_LogLastUpdate 
on <schemaName,,dbo>.<tableName,,>
<TriggerWhen,,after> <TriggerWhat,,update>
as
/* who				when			what
<Creator,,petervandivier>		<createDate,,>	<Description,,TRIGGER to log update revisions>
*/
begin
	set nocount on;
	
	update <schemaName,,dbo>.<tableName,,> set 
		LastUpdateBy = replace( system_user, 'GRCORP\', '' ),
		LastUpdateDatetime = getdate(),
		Revision += 1
	from <schemaName,,dbo>.<tableName,,> a
	join inserted b on a.<PK,,> = b.<PK,,>;
end;
go
