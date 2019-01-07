const n = 15;

type T_VECTOR = array [0..2 * n] of integer;

procedure readV (f: text; var size: byte; var vect: T_VECTOR);
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

procedure twinsertsort(var vect: T_VECTOR; size: byte);
var sort: T_VECTOR;
    i, j, k, right, left, l, r: byte;
    flag: boolean;
    c, m:word; //c - comparisons, m - moves
begin
  c:=0;
  m:=0;
  sort[size]:=vect[0];
  right:=size;
  left:=size;
  for i:= 1 to size - 1 do begin
    flag:=false;
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
            while (flag = false)do begin//(sort[j + 1] < vect[i]) do begin
              j:= (l + r) div 2;
              if (sort[j] < vect[i])
                then l:= j + 1
                else if (sort[j] > vect[i])
                  then r:= j - 1;
              //inc(c);
              if (vect[i] <= sort[j + 1]) and (vect[i] >= sort[j])
                then flag:=true;
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
   // printsort(left, right, sort);
   // printsort(0, 2*n, sort);
   // writeln('Перестановок: ',m,'. Сравнений: ',c);
   // writeln;
  end;
  k:=0;
    for j:= left to right do begin
      vect[k]:=sort[j];
      inc(k);
    end;
end;

procedure partitionAndMerge(var a, b: T_VECTOR; size, step: byte);
var l_down, r_down: byte;
    leng_r, leng_l: byte;
    j, i:byte;
begin
  j:= 0;
  repeat
    l_down:= j;
    r_down:= j + step;
    leng_l:= step;
    if (j + leng_l + step > size)
      then leng_r:= size mod step
      else leng_r:= step;
    if (r_down >= size)
      then begin
        for i:= j to size - 1 do begin
          b[i]:=a[i];
          inc(j);
        end;
      end
      else begin
        repeat
        if (a[l_down] = a[r_down])
          then begin
            b[j]:=a[l_down];
            b[j + 1]:= a[l_down];
            j:= j + 2;
            inc(l_down);
            inc(r_down);
            dec(leng_r);
            dec(leng_l);
          end
          else if (a[l_down] < a[r_down])
            then begin
              b[j]:=a[l_down];
              inc(l_down);
              inc(j);
              dec(leng_l);
            end
            else begin
              b[j]:=a[r_down];
              inc(r_down);
              inc(j);
              dec(leng_r);
            end;
        until (leng_r = 0) or (leng_l = 0);
        if (leng_r > 0)
          then begin
            for i:= r_down to r_down + leng_r - 1 do begin
              b[j]:=a[i];
              inc(j);
            end;             
          end;
        if (leng_l > 0) 
          then begin
            for i:= l_down to l_down + leng_l - 1 do begin
              b[j]:=a[i];
              inc(j);
            end;
          end;
          end;
        until (j >= size );
end;

procedure mergesort(var vect: T_VECTOR; size: byte);
var sort: T_VECTOR;
    step :byte;
    up: boolean;
begin
  up:= true;
  step:=1;
  while (step < size) do begin
        if (up = true)
          then partitionAndMerge(vect, sort, size, step)
          else partitionAndMerge(sort, vect, size, step);
        up:= not up;
        step:= step * 2;
  end;
  if (up = false)
    then vect:= sort;
end;

var vect: T_VECTOR;
    size: byte;
    init: text;
begin
  assign(init,'init.txt');
  reset(init);
  readV(init, size, vect);
  //mergesort(vect, size);
  twinsertsort(vect, size);
  printsort(0, size - 1, vect);
  close(init);
end.