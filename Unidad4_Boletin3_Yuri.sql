/*  1. Por cada cliente, contar el número de cuentas bancarias que posee sin movimientos.
Se deben mostrar los siguientes campos: apellidos, nombre, num_cuentas_sin_movimiento
(tomar como base el ejercicio 16 de las consultas de resumen)   */

select nombre, apellidos, count(cod_cuenta)as num_cuentas_sin_movimiento 
from cuenta join cliente on cuenta.cod_cliente=cliente.cod_cliente
where cuenta.cod_cuenta not in (select cod_cuenta from movimiento) 
group by cuenta.COD_CLIENTE;

/*  2. Mostrar los datos de aquellos clientes que en todas sus cuentas posean un saldo mayor de
15.000 euros.   */
select * from cliente natural join cuenta where cod_cliente not in (select cod_cliente from cuenta where saldo<15000) group by cod_cliente;

/* USANDO ALL */
--select * from cliente where cod_cliente>all (select cod_cliente from cuenta where saldo>15000);


/*  3. Mostrar los datos de aquellos clientes que alguna de sus cuentas posean un saldo superior a
60.000 euros.   */
select * from cliente where cod_cliente=any (select cod_cliente from cuenta where saldo>60000);

/*  4. Mostrar los datos de aquellas cuentas que tenga algún movimiento a las 14:15 horas.  */

select * from cuenta where cod_cuenta in (select cod_cuenta from movimiento where Date_format(movimiento.fecha_hora, '%H-%i')='14-15');

/*  5. Mostrar los datos de aquellas cuentas que no tengan movimientos del tipo PT (pago con
tarjeta).   */
select * from cuenta where cod_cuenta not in (select cod_cuenta from movimiento where cod_tipo_movimiento='PT');

/*  6. Mostrar los datos de las cuentas de las que no existan movimientos.  */

select * from cuenta where cod_cuenta not in (select cod_cuenta from movimiento);

/*  7. Mostrar los datos de las cuentas que tienen más de 1 movimiento del tipo PT (pago con tarjeta).   */
select * from cuenta where cod_cuenta in (select cod_cuenta from movimiento where cod_tipo_movimiento like 'PT' group by cod_cuenta having count(cod_tipo_movimiento)>1);

/*  10. Obtener los tres últimos caracteres de los nombres de proveedores por orden alfabético. */
