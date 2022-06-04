package br.edu.fateczl.ExemploREST.model.entity;

import java.io.Serializable;

public class NotasPK implements Serializable {
	
	    private static final long serialVersionUID = 1L;
	    private Aluno aluno;
	    private Disciplina disciplina;
	    private Avaliacao avaliacao;
	    private double nota;
	    
		public Aluno getAluno() {
			return aluno;
		}
		public void setAluno(Aluno aluno) {
			this.aluno = aluno;
		}
		public Disciplina getDisciplina() {
			return disciplina;
		}
		public void setDisciplina(Disciplina disciplina) {
			this.disciplina = disciplina;
		}
		public Avaliacao getAvaliacao() {
			return avaliacao;
		}
		public void setAvaliacao(Avaliacao avaliacao) {
			this.avaliacao = avaliacao;
		}
		public double getNota() {
			return nota;
		}
		public void setNota(double nota) {
			this.nota = nota;
		}
		@Override
		public String toString() {
			return "NotasPK [aluno=" + aluno + ", disciplina=" + disciplina + ", avaliacao=" + avaliacao + ", nota="
					+ nota + "]";
		}
}
