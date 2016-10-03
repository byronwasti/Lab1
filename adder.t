#! /usr/local/Cellar/icarus-verilog/10.0/bin/vvp
:ivl_version "10.0 (stable)" "(v10_0)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision - 12;
:vpi_module "system";
:vpi_module "vhdl_sys";
:vpi_module "v2005_math";
:vpi_module "va_math";
S_0x7f80b8f00a90 .scope module, "testFullAdder" "testFullAdder" 2 5;
 .timescale -9 -12;
v0x7f80b8f1f9d0_0 .var "a", 0 0;
v0x7f80b8f1fa60_0 .var "b", 0 0;
v0x7f80b8f1faf0_0 .var "carryin", 0 0;
v0x7f80b8f1fba0_0 .net "carryout", 0 0, L_0x7f80b8f202d0;  1 drivers
v0x7f80b8f1fc50_0 .net "sum", 0 0, L_0x7f80b8f20690;  1 drivers
S_0x7f80b8f0f690 .scope module, "adder" "fullAdder" 2 9, 3 8 0, S_0x7f80b8f00a90;
 .timescale -9 -12;
    .port_info 0 /OUTPUT 1 "sum"
    .port_info 1 /OUTPUT 1 "carryout"
    .port_info 2 /INPUT 1 "a"
    .port_info 3 /INPUT 1 "b"
    .port_info 4 /INPUT 1 "carryin"
L_0x7f80b8f1fd20/d .functor AND 1, v0x7f80b8f1fa60_0, v0x7f80b8f1faf0_0, C4<1>, C4<1>;
L_0x7f80b8f1fd20 .delay 1 (30000,30000,30000) L_0x7f80b8f1fd20/d;
L_0x7f80b8f1fe90/d .functor AND 1, v0x7f80b8f1f9d0_0, v0x7f80b8f1faf0_0, C4<1>, C4<1>;
L_0x7f80b8f1fe90 .delay 1 (30000,30000,30000) L_0x7f80b8f1fe90/d;
L_0x7f80b8f1ffd0/d .functor AND 1, v0x7f80b8f1f9d0_0, v0x7f80b8f1fa60_0, C4<1>, C4<1>;
L_0x7f80b8f1ffd0 .delay 1 (30000,30000,30000) L_0x7f80b8f1ffd0/d;
L_0x7f80b8f20130/d .functor OR 1, L_0x7f80b8f1fe90, L_0x7f80b8f1fd20, C4<0>, C4<0>;
L_0x7f80b8f20130 .delay 1 (30000,30000,30000) L_0x7f80b8f20130/d;
L_0x7f80b8f202d0/d .functor OR 1, L_0x7f80b8f20130, L_0x7f80b8f1ffd0, C4<0>, C4<0>;
L_0x7f80b8f202d0 .delay 1 (30000,30000,30000) L_0x7f80b8f202d0/d;
L_0x7f80b8f20480/d .functor XOR 1, v0x7f80b8f1f9d0_0, v0x7f80b8f1fa60_0, C4<0>, C4<0>;
L_0x7f80b8f20480 .delay 1 (50000,50000,50000) L_0x7f80b8f20480/d;
L_0x7f80b8f20690/d .functor XOR 1, L_0x7f80b8f20480, v0x7f80b8f1faf0_0, C4<0>, C4<0>;
L_0x7f80b8f20690 .delay 1 (50000,50000,50000) L_0x7f80b8f20690/d;
v0x7f80b8f03240_0 .net "a", 0 0, v0x7f80b8f1f9d0_0;  1 drivers
v0x7f80b8f1f320_0 .net "aandb", 0 0, L_0x7f80b8f1ffd0;  1 drivers
v0x7f80b8f1f3c0_0 .net "aandc", 0 0, L_0x7f80b8f1fe90;  1 drivers
v0x7f80b8f1f450_0 .net "axorb", 0 0, L_0x7f80b8f20480;  1 drivers
v0x7f80b8f1f4f0_0 .net "b", 0 0, v0x7f80b8f1fa60_0;  1 drivers
v0x7f80b8f1f5d0_0 .net "bandc", 0 0, L_0x7f80b8f1fd20;  1 drivers
v0x7f80b8f1f670_0 .net "bcorac", 0 0, L_0x7f80b8f20130;  1 drivers
v0x7f80b8f1f710_0 .net "carryin", 0 0, v0x7f80b8f1faf0_0;  1 drivers
v0x7f80b8f1f7b0_0 .net "carryout", 0 0, L_0x7f80b8f202d0;  alias, 1 drivers
v0x7f80b8f1f8c0_0 .net "sum", 0 0, L_0x7f80b8f20690;  alias, 1 drivers
    .scope S_0x7f80b8f00a90;
T_0 ;
    %vpi_call 2 14 "$display", "A  B  CI | Sum CO | Sum CO (Expected Output)" {0 0 0};
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1f9d0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1fa60_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1faf0_0, 0, 1;
    %delay 500000, 0;
    %vpi_call 2 16 "$display", "%b  %b  %b  |   %b  %b | 0   0", v0x7f80b8f1f9d0_0, v0x7f80b8f1fa60_0, v0x7f80b8f1faf0_0, v0x7f80b8f1fc50_0, v0x7f80b8f1fba0_0 {0 0 0};
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1f9d0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1fa60_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1faf0_0, 0, 1;
    %delay 500000, 0;
    %vpi_call 2 18 "$display", "%b  %b  %b  |   %b  %b | 1   0", v0x7f80b8f1f9d0_0, v0x7f80b8f1fa60_0, v0x7f80b8f1faf0_0, v0x7f80b8f1fc50_0, v0x7f80b8f1fba0_0 {0 0 0};
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1f9d0_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1fa60_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1faf0_0, 0, 1;
    %delay 500000, 0;
    %vpi_call 2 20 "$display", "%b  %b  %b  |   %b  %b | 1   0", v0x7f80b8f1f9d0_0, v0x7f80b8f1fa60_0, v0x7f80b8f1faf0_0, v0x7f80b8f1fc50_0, v0x7f80b8f1fba0_0 {0 0 0};
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1f9d0_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1fa60_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1faf0_0, 0, 1;
    %delay 500000, 0;
    %vpi_call 2 22 "$display", "%b  %b  %b  |   %b  %b | 0   1", v0x7f80b8f1f9d0_0, v0x7f80b8f1fa60_0, v0x7f80b8f1faf0_0, v0x7f80b8f1fc50_0, v0x7f80b8f1fba0_0 {0 0 0};
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1f9d0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1fa60_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1faf0_0, 0, 1;
    %delay 500000, 0;
    %vpi_call 2 24 "$display", "%b  %b  %b  |   %b  %b | 1   0", v0x7f80b8f1f9d0_0, v0x7f80b8f1fa60_0, v0x7f80b8f1faf0_0, v0x7f80b8f1fc50_0, v0x7f80b8f1fba0_0 {0 0 0};
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1f9d0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1fa60_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1faf0_0, 0, 1;
    %delay 500000, 0;
    %vpi_call 2 26 "$display", "%b  %b  %b  |   %b  %b | 0   1", v0x7f80b8f1f9d0_0, v0x7f80b8f1fa60_0, v0x7f80b8f1faf0_0, v0x7f80b8f1fc50_0, v0x7f80b8f1fba0_0 {0 0 0};
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7f80b8f1f9d0_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1fa60_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1faf0_0, 0, 1;
    %delay 500000, 0;
    %vpi_call 2 28 "$display", "%b  %b  %b  |   %b  %b | 0   1", v0x7f80b8f1f9d0_0, v0x7f80b8f1fa60_0, v0x7f80b8f1faf0_0, v0x7f80b8f1fc50_0, v0x7f80b8f1fba0_0 {0 0 0};
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1f9d0_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1fa60_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7f80b8f1faf0_0, 0, 1;
    %delay 500000, 0;
    %vpi_call 2 30 "$display", "%b  %b  %b  |   %b  %b | 1   1", v0x7f80b8f1f9d0_0, v0x7f80b8f1fa60_0, v0x7f80b8f1faf0_0, v0x7f80b8f1fc50_0, v0x7f80b8f1fba0_0 {0 0 0};
    %end;
    .thread T_0;
# The file index is used to find the file name in the following table.
:file_names 4;
    "N/A";
    "<interactive>";
    "adder.t.v";
    "./adder.v";
