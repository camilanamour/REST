package br.edu.fateczl.ExemploREST.model.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.lang.NonNull;

@Entity
@Table(name = "notas")
@IdClass(NotasPK.class)

public class Notas {

	@Id
	@ManyToOne(targetEntity = Aluno.class)
	@JoinColumn(name = "ra_aluno")
	@NonNull
	private Aluno aluno;

	@Id
	@ManyToOne(targetEntity = Disciplina.class)
	@JoinColumn(name = "codigo_disciplina")
	@NonNull
	private Disciplina disciplina;
	
	@Id
	@ManyToOne(targetEntity = Avaliacao.class)
	@JoinColumn(name = "codigo_avaliacao")
	@NonNull
	private Avaliacao avaliacao;

	@Column(name = "nota")
	@NonNull
	private double nota;
}
