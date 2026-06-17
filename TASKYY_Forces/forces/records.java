// Rekordy (records), wprowadzone na stałe w Javie 16, to "odchudzone" klasy, 
// których głównym celem jest bycie czystymi kontenerami na dane. 
// Rozwiązują one problem tzw. boilerplate'u (powtarzalnego kodu), 
// który musiałbyś pisać dla zwykłej klasy.

//import java.lang.Record; //???

public record Point(int x, int y) { }

public record Color(int r, int g, int b) {
    // Konstruktor kompaktowy - brak nawiasów (r, g, b)
    public Color {
        if (r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || b > 255) {
            throw new IllegalArgumentException("Kolory muszą być w zakresie 0-255!");
        }
    }
}