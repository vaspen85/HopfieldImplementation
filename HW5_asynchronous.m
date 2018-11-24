Vs = [1, 1, 1, 0, 1, 0, 0, 1, 0;
      1, 0, 1, 1, 0, 1, 1, 1, 1; 
      1, 0, 1, 0, 1, 0, 1, 0, 1; 
      0, 1, 0, 0, 1, 0, 1, 1, 1; 
      1, 0, 0, 1, 0, 0, 1, 1, 1; 
      1, 1, 1, 1, 0, 1, 1, 1, 1]; 
W = zeros(9,9);
S = [];
V = [];
G = [];
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
V = dec2bin(0:2.^9-1)-'0'; 

%update all initial vectors
for i=1:512
  counter = 0;
  flag = 1;
  instate = V(i,:).';
  %apply f function
  while flag == 1
    for j=1:9
      S(i,j) = W(j,:)*instate;
      if S(i,j) > 0
        S(i,j) = 1;
      elseif S(i,j) < 0
        S(i,j) = 0;
      else 
        S(i,j) = instate(j);
      end
      if !isequal(S(i,j), instate(j))
        instate(j) = S(i,j);
      end 
    end
    %check if S(i,j) is stable state
     G(i,:) = W*instate;
    for j=1:9  
      if G(i,j) > 0
        G(i,j) = 1;
      elseif G(i,j) < 0
        G(i,j) = 0;
      else 
        G(i,j) = instate(j);
      end
      if isequal(G(i,:),instate.')
        flag = 0;
      end
    end
    counter = counter + 1;
  end  
  fprintf('%s \t\t %s \t\t %d\n', num2str(V(i,:)(:)), num2str(G(i,:)(:)), counter);
end