const n = 8;

type T_VECTOR = array [0..2 * n] of integer;

procedure readV (f: text; var size: word; var vect: T_VECTOR);
var s, num: string;
begin
  size:=0;
    readln(f, s);
    while (s <> '') do begin
    inc(size);
    num:=copy(s,1,pos(' ', s) - 1);
    vect[size-1]:= strtoint(num);
    delete(s, 1, pos(' ', s));
  end
end;

procedure printsort(left, right: word; const sort: T_VECTOR);
var k: word;
begin
  for k:= left to right do
      write(sort[k],' ');
 writeln;
end;

procedure twinsertsort(var vect: T_VECTOR; size: word);
var sort: T_VECTOR;
    i, j, k, right, left, l, r: word;
    c, m:word; //c - comparisons, m - moves
begin
  c:=0;
  m:=0;
  sort[size]:=vect[0];
  right:=size;
  left:=size;
  for i:= 1 to size - 1 do begin
    if (vect[i] <= sort[left])
      then begin
        inc(c);
        left:= left - 1;
        sort[left]:= vect[i];
      end
      else if (vect[i] >= sort[right])
        then begin
          inc(c);
          right:=right + 1;
          sort[right]:=vect[i];
        end 
        else begin
            j:=left;
            l:= left;
            r:=right;
            inc(c);
            while (sort[j + 1] < vect[i]) {(l < r)} do begin
              //inc(j); 
              j:= (l + r) div 2;
              if (sort[j] < vect[i])
                then l:= j + 1
                else if (sort[j] > vect[i])
                  then r:= j - 1;
                  
              inc(c);
            end;
            if (j - left < right - j)
              then begin 
                for k:= left to j do begin
                   sort[k - 1]:= sort[k];
                   inc(m);
                 end;
                dec(left);
                sort[j]:=vect[i];
               end
              else begin 
                for k:= right downto j + 1 do begin
                   sort[k + 1]:= sort[k];
                   inc(m);
                 end;
                 inc(right);
                 sort[j+1]:=vect[i];
              end;
        end;
    printsort(left, right, sort);
    //printsort(0, 2*n, sort);
    writeln('Перестановок: ',m,'. Сравнений: ',c);
    writeln;
  end;
  k:=0;
    for j:= left to right do begin
      vect[k]:=sort[j];
      inc(k);
    end;
end;


function mergesort (var vect: T_VECTOR; size: word): T_VECTOR;
vsr
begin
  
end;

var vect: T_VECTOR;
    size: word;
    time, total: integer;
    init, outp: text;
begin
  assign(init,'init.txt');
  reset(init);
  readV(init, size, vect);
  twinsertsort(vect, size);
  close(init);
end.