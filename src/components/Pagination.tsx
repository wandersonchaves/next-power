import React from 'react'

interface PaginationProps {
  currentPage: number
  totalPages: number
  onPageChange: (page: number) => void
}

const Pagination: React.FC<PaginationProps> = ({
  currentPage,
  totalPages,
  onPageChange,
}) => {
  return (
    <div className="mt-4 flex justify-center">
      <button
        className="mx-1 rounded border px-3 py-1"
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
      >
        Anterior
      </button>
      {[...Array(totalPages)].map((_, index) => (
        <button
          key={index}
          className={`mx-1 rounded border px-3 py-1 ${
            currentPage === index + 1 ? 'bg-gray-300' : ''
          }`}
          onClick={() => onPageChange(index + 1)}
        >
          {index + 1}
        </button>
      ))}
      <button
        className="mx-1 rounded border px-3 py-1"
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages}
      >
        Próximo
      </button>
    </div>
  )
}

export default Pagination
