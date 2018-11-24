fid = fopen ("myfile.txt", "w");
Vs = [1, 1, 1, 0, 1, 0, 0, 1, 0;
      1, 0, 1, 1, 0, 1, 1, 1, 1; 
      1, 0, 1, 0, 1, 0, 1, 0, 1; 
      0, 1, 0, 0, 1, 0, 1, 1, 1; 
      1, 0, 0, 1, 0, 0, 1, 1, 1; 
      1, 1, 1, 1, 0, 1, 1, 1, 1]; 
W = zeros(9,9);
S = [];
V = [];
%d = 2; %for the first question
d = 6; %for second question 
%Vs matrix
for k=1:d 
  for i=1:9
    for j=1:9
      W(i,j) = W(i,j) + (2.*Vs(k,i)-1).*(2.*Vs(k,j)-1);
      if i==j
        W(i,j) = 0;
      end
    end
  end  
end


%create all 512 states
V = dec2bin(0:2^9-1)-'0'; 

%update all initial vectors

for j=1:512
  instate = V(j,:).';
  counter = 0;
  flag = 1;
  while flag == 1 && counter < 512
    S(j,:) = W*instate;
    for i=1:9
      if S(j,i) > 0
        S(j,i) = 1;
      elseif S(j,i) < 0
        S(j,i) = 0;
      else 
        S(j,i) = instate(i);
      end
    end    
    if isequal(S(j,:),instate.')   
      flag = 0;   
    end
    instate = S(j,:).';
    counter = counter+1;
  end  
  if counter < 512
    fprintf('%s \t\t %s \t\t %d\n', num2str(V(j,:),(:)), num2str(instate(:)), counter);
  else 
    fprintf('%s \t\t %s \t\t oscillation\n', num2str(V(j,:),(:)), num2str(instate(:)) );
  end
end  