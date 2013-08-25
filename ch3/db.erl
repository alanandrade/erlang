-module(db).

% Creates a database and is able to store, retrieve and delete elements in it.
% The destroy/1 function will delete the database. Considering that Erlang has
% garbage collection, you do not need to anything. Had the db module stored
% everything on file, however, you would delete the file.
% We are including the destroy functino to make the interface consistent. You
% may not use the lists library module, and you have to implement all the
% recursive functions yourself.
%
% Hint: use lists and tuples as your main data structures. When testint your
% program, remember that Erlang varibles are single-assignment:
%
% Interface:
%
%   db:new()        => Db.
%   db:destroy(Db)  => ok.
%   db:write(Key, Element, Db) => NewDb.
%   db:delete(Key, Db)  => NewDb.
%   db:read(Key, Db)    => {ok, Element} | {error, instance}.
%   db:match(Element, Db) => [Key1, ..., KeyN].
%
%
% Example:
%
%   1> c(db).
%   {ok, db}
%
%   2> Db = db:new().
%   []
%
%   3> Db1 = db:write(francesco, london, Db).
%   [{francesco, london}]
%
%   4> Db2 = db:write(lelle, stockholm, Db1).
%   [{lelle, stockholm},{francesco, london}]
%
%   5> db:read(francesco, Db2).
%   {ok, london}
%
%   6> Db3 = db:write(joern, stockholm, Db2).
%   [{joern, stockholm}, {lelle, stockholm}, {francesco, london}]
%
%   7> db:read(ola, Db3).
%   {error, instance}
%
%   8> db:match(stockholm, Db3).
%   [joern, lelle]
%
%   9> Db4 = db:delete(lelle, Db3).
%   [{joern stockholm}, {francesco, london}]
%
%   10> db:match(stockholm, Db4).
%   [joern]

-export([new/0, write/3, read/2]).

new () ->
  [].

write (Key, Element, Db) ->
  [{ Key, Element }|Db].

% The [H|T] Head matches the Key.
read (Key, [{Key, Element}|_])  -> {ok, Element};
% We iterate over until the list end.
read (_, []) -> {error, instance};
% Anything matches from above, recursion with Tail.
read (Key, [_|T]) ->
  read(Key, T).  % {alan, mexico}
