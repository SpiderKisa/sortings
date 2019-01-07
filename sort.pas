const n = 10;

type T_VECTOR = array [0..2 * n + 1] of integer;

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

procedure mergesort(vect: T_VECTOR; size: byte);
var sort: T_VECTOR;
    i, j, step :byte;
    up, flag: boolean;
    r_down, l_down, r_up, l_up: byte;
    leng_r, leng_l : byte;
begin
  for i:=1 to size - 1 do
    sort[i]:=vect[i];
  up:= true;
  step:=1;



step:= step * 2;
    flag:=false;
    if (up = true)
      then begin
        l_down:= 0;
        r_down:= step;
        l_up:= size;
        r_up:= size + step;
        j:= size;
      end
      else begin
        l_up:= 0;
        r_up:= step;
        l_down:= size;
        r_down:=size + step;
        j:= 0;
      end;я


  while (step < (size-1) div 2) do begin
    
      repeat
        leng_r:= step;
        leng_l:= step;
        repeat
          if (sort[l_down] <= sort[r_down])
            then begin
              sort[j]:=sort[l_down];
              inc(l_down);
              inc(j);
              dec(leng_l);
            end
            else begin
              sort[j]:=sort[r_down];
              inc(r_down);
              inc(j);
              dec(leng_r);
            end;
        until (leng_r = 0) and (leng_l = 0);
        if (leng_r > 0)
          then begin
            for i:= r_down to r_down + leng_r do begin
              sort[j]:=sort[i];
              inc(j);
            end;             
          end;
        if (leng_l > 0) 
          then begin
            for i:= l_down to l_down + leng_l do begin
              sort[j]:=sort[i];
              inc(j);
            end;
          end;
          if (up = true)
            then if (j = size - 1)
                then flag:=true;
          if (up = false)
            then if (j = 2 * size - 1)
              then flag:= true;
        //until ((l_down - r_down - 1) < step);
        until (flag = false);
        up:= not up;
  end;
  
end;

var vect: T_VECTOR;
    size: byte;
    time, total: integer;
    init, outp: text;
begin
  assign(init,'init.txt');
  reset(init);
  readV(init, size, vect);
  mergesort(vect, size);
  close(init);
end.