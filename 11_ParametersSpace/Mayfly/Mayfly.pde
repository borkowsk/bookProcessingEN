// @file
// @brief Logistic map model with two alternating parameter values R
// English translation of the original Delphi version by Copilot

final float x0 = 0.5;      // If 0 or less, it will be random
final int iterations = 300;  // Number of iterations
final int division = 100;
final int startR = round(0 * division);    // Start of the r range
final int endR = round(4 * division);      // End of the r range
final int widthPx = 2 * (endR - startR) + 170;
final int heightPx = 2 * (endR - startR) + 20;

float[] timeSeries = new float[iterations + 1];  // Array for the time series

float meanValue() {
  // Simple arithmetic mean of the "timeSeries" array
  float total = 0;
  for (int i = 0; i <= iterations; i++) {
    total += timeSeries[i];
  }
  return total / (iterations + 1);
}

float lyapunovExponent(float r1, float r2) {
  // Calculates the Lyapunov exponent for given r1 and r2
  float sum = 0;
  for (int i = 0; i <= iterations; i++) {
    float x = timeSeries[i];
    float a;

    if (i % 2 == 0) {
      a = abs(r1 - 2 * r1 * x);
    } else {
      a = abs(r2 - 2 * r2 * x);
    }

    if (a > 0) {
      sum += log(a) / log(2);
    }
  }

  return sum / (iterations + 1);
}

float autocorrelation(int step) {
  // Calculates autocorrelation with the given shift
  float xMean = 0;
  float yMean = 0;
  float sum1 = 0;
  float sum2 = 0;
  float sum3 = 0;

  // Compute means
  for (int i = 0; i <= iterations - step; i++) {
    xMean += timeSeries[i];
  }
  for (int i = step; i <= iterations; i++) {
    yMean += timeSeries[i];
  }

  xMean /= (iterations - step);
  yMean /= (iterations - step);

  // Main autocorrelation calculation
  for (int i = 0; i <= iterations - step; i++) {
    sum1 += (xMean - timeSeries[i]) * (yMean - timeSeries[i + step]);
    sum2 += sq(xMean - timeSeries[i]);
    sum3 += sq(yMean - timeSeries[i + step]);
  }

  if (sum2 > 0 && sum3 > 0) {
    return sum1 / (sqrt(sum2) * sqrt(sum3));
  } else {
    return 0;
  }
}

void setLyapunovColor(float value) {
  // Map value to color for Lyapunov exponent
  if (value > 0) {
    stroke(round(value * 255), round(value * 50), 0);
  } else {
    stroke(0, round(-value * 25), round(-value * 255));
  }
}

void setAverageColor(float value) {
  // Map value to color for average/autocorrelation
  if (value > 0) {
    stroke(round(value * 255), round(value * 255), 0);
  } else {
    stroke(0, round(-value * 255), round(-value * 255));
  }
}

void settings() {
  size(widthPx, heightPx);
  noSmooth();
}

void setup() {
  background(255);
  noLoop();

  float minLyapunov = 0;
  float maxLyapunov = 1;

  // Main iteration loop
  for (int k = startR; k <= endR; k++) {
    for (int j = startR; j <= endR; j++) {
      float x;

      if (x0 <= 0) {
        x = random(1);
      } else {
        x = x0;
      }

      timeSeries[0] = x;

      float r1 = (float)k / division;
      float r2 = (float)j / division;

      // Logistic map iteration
      for (int i = 1; i <= iterations; i++) {
        if (i % 2 == 0) {
          x = r1 * x * (1 - x);
        } else {
          x = r2 * x * (1 - x);
        }
        timeSeries[i] = x;
      }

      // Draw Lyapunov exponent
      float lyapunov = lyapunovExponent(r1, r2);
      if (lyapunov > maxLyapunov) maxLyapunov = lyapunov;
      if (lyapunov < minLyapunov) minLyapunov = lyapunov;
      setLyapunovColor(lyapunov);
      point((endR - startR) + 10 + k - startR, j - startR);

      // Draw mean
      float mean = meanValue();
      setAverageColor(mean);
      point(k - startR, (endR - startR) + 10 + j - startR);

      // Draw autocorrelation
      float correlation = autocorrelation(5);
      setAverageColor(correlation);
      point((endR - startR) + 10 + k - startR, (endR - startR) + 10 + j - startR);

      // Draw final state
      setLyapunovColor(x);
      point(k - startR, j - startR);
    }
  }

  // Legend
  int legendIndex = (endR - startR);

  for (int k = 0; k <= legendIndex; k++) {
    float value = minLyapunov + k / (float)legendIndex * (maxLyapunov - minLyapunov);

    // Draw Lyapunov scale
    setLyapunovColor(value);
    line(2 * legendIndex + 50, k + 1, 2 * legendIndex + 80, k + 1);

    // Draw average scale from -1 to 1
    value = -1.0 + k / (float)legendIndex * 2;
    setAverageColor(value);
    line(2 * legendIndex + 50, legendIndex + k + 10, 2 * legendIndex + 80, legendIndex + k + 10);
  }

  // Labels
  fill(0);
  textSize(10);
  text(nf(minLyapunov, 2, 2), 2 * legendIndex + 82, 15);
  text(nf(maxLyapunov, 2, 2), 2 * legendIndex + 82, legendIndex - 5);
  text(nf(-1.0, 2, 2), 2 * legendIndex + 82, legendIndex + 20);
  text(nf(1.0, 2, 2), 2 * legendIndex + 82, 2 * legendIndex - 5);
}

//void draw() {
  // Drawing is already done in setup()
//}
