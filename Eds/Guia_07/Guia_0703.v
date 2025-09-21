// ------------------------- 
// Guia_0703 - LU (AND, NAND, OR, NOR) 
// Nome: Gabriel Ferreira Pereira 
// Matricula: 842527 
// ------------------------- 

// ------------------------- 
// f9_gate = unidade lógica (gera as 4 portas) 
// ------------------------- 
module f9 (
    output s_and,
    output s_nand,
    output s_or,
    output s_nor,
    input  a,
    input  b
);

    // portas nativas
    and  AND1 (s_and,  a, b);
    nand NAND1(s_nand, a, b);
    or   OR1  (s_or,   a, b);
    nor  NOR1 (s_nor,  a, b);

endmodule // f9

// ------------------------- 
// mux 2x1 feito com portas
// ------------------------- 
module mux (
    output s,
    input  a,
    input  b,
    input  select
);
    wire not_select;
    wire sa, sb;

    not NOT1 (not_select, select);
    and AND1 (sa, a, not_select);
    and AND2 (sb, b, select);
    or  OR1  (s, sa, sb);
endmodule // mux

// ------------------------- 
// Teste
// ------------------------- 
module test_f9;
    // definir dados
    reg  x;
    reg  y;
    reg  sel_op;   // seleção da porta (0-NAND/NOR ; 1-AND/OR)
    reg  sel_grp;  // seleção do grupo (0-AND/NAND ; 1-OR/NOR)

    wire w_and;
    wire w_nand;
    wire w_or;
    wire w_nor;

    wire z1;   // saída do grupo AND/NAND
    wire z2;   // saída do grupo OR/NOR
    wire z;    // saída final

    // instancia unidade lógica
    f9 modulo (w_and, w_nand, w_or, w_nor, x, y);

    // primeiro nível: escolher dentro de cada grupo
    mux MUX1 (z1, w_nand, w_and, sel_op); // grupo AND/NAND
    mux MUX2 (z2, w_nor,  w_or,  sel_op); // grupo OR/NOR

    // segundo nível: escolher o grupo
    mux MUX3 (z, z1, z2, sel_grp);

    // parte principal
    initial
    begin : main
        $display("Guia_0703 - Gabriel Ferreira Pereira - 842527");
        $display("Test LU's module (AND, NAND, OR, NOR)");
        $display("x y sel_op sel_grp | AND NAND OR NOR | z");

        // monitor
        $monitor("%b %b    %b      %b   |  %b    %b   %b   %b  | %b",
                  x, y, sel_op, sel_grp, w_and, w_nand, w_or, w_nor, z);

        // aplicar estímulos
        x=0; y=0; sel_op=0; sel_grp=0; #1;
        x=0; y=1; #1;
        x=1; y=0; #1;
        x=1; y=1; #1;

        sel_op=1; sel_grp=0; // testar AND
        x=0; y=0; #1;
        x=0; y=1; #1;
        x=1; y=0; #1;
        x=1; y=1; #1;

        sel_op=0; sel_grp=1; // testar NOR
        x=0; y=0; #1;
        x=0; y=1; #1;
        x=1; y=0; #1;
        x=1; y=1; #1;

        sel_op=1; sel_grp=1; // testar OR