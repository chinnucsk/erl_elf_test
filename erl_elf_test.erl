% Author: Zvi Avraham
% See:
%   Manually creating an ELF executable
%   http://www.negrebskoh.net/howto/howto_elf_exec.html

-module(erl_elf_test).

-compile([export_all]).

code() ->
    <<
    16#7F, 16#45, 16#4C, 16#46, 16#01, 16#01, 16#01, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#10, 16#02, 16#00, 16#03, 16#00,
    16#01, 16#00, 16#00, 16#00, 16#80, 16#80, 16#04, 16#08, 16#34, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00,
    16#34, 16#00, 16#20, 16#00, 16#02, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#01, 16#00, 16#00, 16#00, 16#80, 16#00, 16#00, 16#00,
    16#80, 16#80, 16#04, 16#08, 16#00, 16#00, 16#00, 16#00, 16#24, 16#00, 16#00, 16#00, 16#24, 16#00, 16#00, 16#00, 16#05, 16#00, 16#00, 16#00,
    16#00, 16#10, 16#00, 16#00, 16#01, 16#00, 16#00, 16#00, 16#A4, 16#00, 16#00, 16#00, 16#A4, 16#80, 16#04, 16#08, 16#00, 16#00, 16#00, 16#00,
    16#20, 16#00, 16#00, 16#00, 16#20, 16#00, 16#00, 16#00, 16#07, 16#00, 16#00, 16#00, 16#00, 16#10, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00,
    16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#00, 16#BB, 16#01, 16#00, 16#00, 16#00, 16#B8, 16#04, 16#00, 16#00, 16#00, 16#B9, 16#A4,
    16#80, 16#04, 16#08, 16#BA, 16#B1, 16#80, 16#04, 16#08, 16#CD, 16#80, 16#B8, 16#01, 16#00, 16#00, 16#00, 16#BB, 16#2A, 16#00, 16#00, 16#00,
    16#CD, 16#80, 16#00, 16#00
    >>.

data() ->
    %<<16#48, 16#65, 16#6C, 16#6C, 16#6F, 16#20, 16#57, 16#6F, 16#72, 16#6C, 16#64, 16#21, 16#0A, 16#0D>>.
    Str = <<"Hello World from ELF executable!\n">>,
    <<Str/bytes, (byte_size(Str)):8>>.

test() ->
    ok = file:write_file("hello.elf", [code(), data()]),
    ok = file:change_mode("hello.elf", 8#755), % same as chmod +x hello.elf
    Output = os:cmd("./hello.elf"),
    io:format("~p~n", [Output]).
