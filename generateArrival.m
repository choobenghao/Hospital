function arrival = generateArrival(N,meanArrival)

arrival=zeros(1,N);

for i=2:N
    interArrival = -meanArrival*log(rand());
    arrival(i)=arrival(i-1)+interArrival;
end

end