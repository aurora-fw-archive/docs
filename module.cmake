message(STATUS "Loading cmake module: documentation")

#Doxygen specific configuration
if(AURORAFW_TARGET_DOCUMENTATION)
	FIND_PACKAGE(Doxygen)
	IF (DOXYGEN_FOUND)
		SET(DOXYGEN_DIR ${CMAKE_MODULE_DOCUMENTATION_DIR})
		SET(DOXYGEN_INPUT ${DOXYGEN_DIR}/Doxyfile)
		set(DOXYGEN_OUTPUT "${DOXYGEN_DIR}/.out_html;${DOXYGEN_DIR}/.out_xml;${DOXYGEN_DIR}/.out_latex;${DOXYGEN_DIR}/.out_docbook;${DOXYGEN_DIR}/.out_man;${DOXYGEN_DIR}/.out_rtf")
		#file(GLOB_RECURSE DOXYGEN_DEPENDS ${AURORAFW_MODULES_DIR} *.cpp *.c *.h *.hpp *.md *.py *.d)

		if(AURORAFW_DOCUMENTATION_AUTO)
			ADD_CUSTOM_COMMAND(OUTPUT ${DOXYGEN_OUTPUT}
							COMMENT "Building Documentation"
							COMMAND ${CMAKE_COMMAND} -E echo_append "Building Documentation..."
							COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_INPUT}
							COMMAND ${CMAKE_COMMAND} -E echo "Done."
							WORKING_DIRECTORY ${DOXYGEN_DIR}
							DEPENDS ${DOXYGEN_INPUT})

			ADD_CUSTOM_TARGET(doxygen ALL
							WORKING_DIRECTORY ${DOXYGEN_DIR}
							DEPENDS ${DOXYGEN_OUTPUT})
		endif()

		ADD_CUSTOM_TARGET(documentation
						COMMENT "Building Documentation"
						COMMAND ${CMAKE_COMMAND} -E echo_append "Building Documentation..."
						COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_INPUT}
						COMMAND ${CMAKE_COMMAND} -E echo "Done."
						WORKING_DIRECTORY ${DOXYGEN_DIR})

		ADD_CUSTOM_TARGET(clean-docs COMMAND rm -rf "${DOXYGEN_DIR}/.out_*/*")
		ADD_CUSTOM_TARGET(clear COMMAND ${CMAKE_BUILD_TOOL} clean)
		add_dependencies(clear clean-docs)
	ENDIF (DOXYGEN_FOUND)
endif()
