package br.edu.fateczl.ExemploREST.model.dto;

public class NotaDTO {

	public AlunoDTO alunoDTO;
	public DisciplinaDTO disciplinaDTO;
	public AvaliacaoDTO avaliacaoDTO;
	public double nota;

	public AlunoDTO getAlunoDTO() {
		return alunoDTO;
	}

	public void setAlunoDTO(AlunoDTO alunoDTO) {
		this.alunoDTO = alunoDTO;
	}

	public DisciplinaDTO getDisciplinaDTO() {
		return disciplinaDTO;
	}

	public void setDisciplinaDTO(DisciplinaDTO disciplinaDTO) {
		this.disciplinaDTO = disciplinaDTO;
	}

	public AvaliacaoDTO getAvaliacaoDTO() {
		return avaliacaoDTO;
	}

	public void setAvaliacaoDTO(AvaliacaoDTO avaliacaoDTO) {
		this.avaliacaoDTO = avaliacaoDTO;
	}

	public double getNota() {
		return nota;
	}

	public void setNota(double nota) {
		this.nota = nota;
	}

	@Override
	public String toString() {
		return "NotaDTO {" + "alunoDTO" + alunoDTO + ", disciplinaDTO=" + disciplinaDTO + ", avaliacaoDTO="
				+ avaliacaoDTO + ", nota=" + nota + '}';
	}

}
