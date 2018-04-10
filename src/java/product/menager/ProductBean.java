package product.menager;

import java.sql.Date;


public class ProductBean {
    int idProduktu;
    String nazwa;
    String rodzaj;
    double cena;
    String nrSeryjny;
    String image;

    public int getIdProduktu() {
        return idProduktu;
    }

    public void setIdProduktu(int idProduktu) {
        this.idProduktu = idProduktu;
    }

    public String getNazwa() {
        return nazwa;
    }

    public void setNazwa(String nazwa) {
        this.nazwa = nazwa;
    }

    public String getRodzaj() {
        return rodzaj;
    }

    public void setRodzaj(String rodzaj) {
        this.rodzaj = rodzaj;
    }

    public double getCena() {
        return cena;
    }

    public void setCena(double cena) {
        this.cena = cena;
    }

    public String getNrSeryjny() {
        return nrSeryjny;
    }

    public void setNrSeryjny(String nrSeryjny) {
        this.nrSeryjny = nrSeryjny;
    }
    
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    
    
    
}
