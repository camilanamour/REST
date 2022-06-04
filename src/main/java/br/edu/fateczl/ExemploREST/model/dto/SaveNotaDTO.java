package br.edu.fateczl.ExemploREST.model.dto;

public class SaveNotaDTO {
	
	private String ra;
    private String codigoDisciplina;
    private int codigoAvaliacao;
    private Double nota;

    public String getRa() {
		return ra;
	}

	public void setRa(String ra) {
		this.ra = ra;
	}
	public String getCodigoDisciplina() {
		return codigoDisciplina;
	}
	public void setCodigoDisciplina(String codigoDisciplina) {
		this.codigoDisciplina = codigoDisciplina;
	}
	public int getCodigoAvaliacao() {
		return codigoAvaliacao;
	}

	public void setCodigoAvaliacao(int codigoAvaliacao) {
		this.codigoAvaliacao = codigoAvaliacao;
	}

	public Double getNota() {
		return nota;
	}
	public void setNota(Double nota) {
		this.nota = nota;
	}

	@Override
    public String toString() {
        return "SaveNotaDTO{" +
                "ra='" + ra + '\'' +
                ", codigoDisciplina='" + codigoDisciplina + '\'' +
                ", codigoAvaliacao='" + codigoAvaliacao + '\'' +
                ", nota=" + nota +
                '}';
    }

}
