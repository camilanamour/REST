package br.edu.fateczl.ExemploREST.model.dto;

import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.JsonTypeName;

@JsonTypeName(value = "avaliacao")
@JsonTypeInfo(include = JsonTypeInfo.As.WRAPPER_OBJECT, use = JsonTypeInfo.Id.NAME)

public class AvaliacaoDTO {

	private int codigo;
	private String tipo;

	public int getCodigo() {
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	public String getNome() {
		return tipo;
	}

	public void setNome(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return "AvaliacaoDTO [codigo=" + codigo + ", tipo=" + tipo + "]";
	}

}
