[A, B, C, D] = linmod('dcengine');
sys = ss(A, B, C, D);
T = tf(sys);

T