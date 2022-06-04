package br.edu.fateczl.ExemploREST.model.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import org.springframework.lang.NonNull;

@Entity
@Table(name = "avaliacao")
public class Avaliacao {	
	@Id
	@JoinColumn(name = "codigo")
	@NonNull
	private int codigo;

	@Column(name = "tipo", length = 5)
	@NonNull
	private String tipo;
	
	public int getCodigo() {
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return "{" +
				"codigo='" + codigo + '\'' +
				", tipo='" + tipo + '\'' +
				'}';
	}
	
	
}
