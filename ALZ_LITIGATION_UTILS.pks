CREATE OR REPLACE PACKAGE CUSTOMER."ALZ_LITIGATION_UTILS"
is
    type lawyer_expense_rec is record(
        code varchar2(5),
        description varchar2(50),
        amount number
    );

    type lawyer_expense_tbl is table of lawyer_expense_rec index by binary_integer;

    v_auth_from_ticket number:=1;

    function get_com_sender_list return sys_refcursor;

    function get_law_doc_side_list(p_user_name varchar2,
                                    p_law_file_no varchar2 default null,
                                    p_uyap_id number default null,
                                    p_company varchar2 default null,
                                    p_ticket_id number default null,
                                    p_ext_reference varchar2 default null) return law_documents_tbl;

    function uyap_to_date(p_input varchar2, p_format varchar2) return date;

    function get_law_documents_list(p_user_name varchar2,
                                p_law_file_no varchar2 default null,
                                p_uyap_id number default null,
                                p_company varchar2 default null,
                                p_ticket_id number default null,
                                p_ext_reference varchar2 default null) return law_documents_tbl;

    procedure save_law_document(p_type in varchar2,
                                p_user_name in varchar2,
                                p_process_results out customer.process_result_table,
                                p_create_ticket_id out number,
                                p_law_file_no in varchar2 default null,
                                p_ticket_id in number default null,
                                p_doc_list in law_documents_tbl default null,
                                p_com in law_com_tbl default null,
                                p_com_party in law_com_party_tbl default null,
                                p_com_reference in law_com_reference_tbl default null,
                                p_com_doc_list in law_com_doc_tbl default null,
                                p_ext_rec in law_ext_documents_hdr_typ default null);

    procedure modify_law_document(p_type in varchar2,
                                  p_modify_type in varchar2,
                                  p_filenet_id in varchar2,
                                  p_user_name in varchar2,
                                  p_process_results out customer.process_result_table,
                                  p_law_file_no in varchar2 default null,
                                  p_com_doc in law_com_doc_typ default null,
                                  p_ticket_id in varchar2 default null);

    function get_uyap_law_file_list(p_uyap_id number) return varchar2;

    procedure send_file(p_ext_reference in varchar2,
                        p_name in varchar2,
                        p_user_name in varchar2,
                        p_dest_supp_type in varchar2,
                        p_ticket_id out number,
                        p_error_msg out varchar2);

    procedure reject_file(p_ext_reference in varchar2,
                          p_user_name in varchar2,
                          p_source_supp_type in varchar2,
                          p_reason_code in number,
                          p_process_results out customer.process_result_table);

    procedure send_file_to_ext_lawyer(p_ticket_id in number,
                                      p_user_name in varchar2,
                                      p_lawyer_user in varchar2,
                                      p_process_results out customer.process_result_table);

    procedure reject_file_by_ext_lawyer(p_ticket_id in number,
                                        p_reason_code in number,
                                        p_process_results out customer.process_result_table);

    procedure approve_file_by_ext_lawyer(p_ticket_id in number,
                                         p_user_name in varchar2,
                                         p_process_results out customer.process_result_table);

    function get_law_file_status(p_law_file_no varchar2) return number;

    function get_reason_code_list(p_from_group varchar2, p_to_group varchar2, p_type varchar2 default null) return sys_refcursor;

    function match_uyap_law_file(p_uyap_id number, p_birim_id varchar2, p_court_file_no varchar2) return varchar2;

    procedure match_ticket_uyap_id(p_law_file_no in varchar2,
                                   p_old_law_file_no in varchar2,
                                   p_uyap_id in number,
                                   p_user_name in varchar2,
                                   p_process_results out customer.process_result_table);

    procedure get_in_lawyer_info(p_law_file_no in varchar2,
                                 p_in_lawyer_user out varchar2,
                                 p_in_lawyer_group out varchar2,
                                 p_process_results out customer.process_result_table);

    function get_sf_type_list(p_department varchar2, p_law_file_no varchar2 default null) return sys_refcursor;

    function get_law_sf_group_list return sys_refcursor;

    function get_law_type_list(p_law_file_no varchar2 default null) return sys_refcursor;

    function get_internal_lawyer_list(p_department in varchar2,
                                      p_law_case_type in varchar2 default null,
                                      p_law_file_type in varchar2 default null,
                                      p_law_sf_type in varchar2  default null,
                                      p_law_file_no in varchar2 default null) return sys_refcursor;

    function get_external_lawyer_list(p_law_file_no varchar2 default null) return sys_refcursor;

    function get_file_status_list return sys_refcursor;

    function get_prosecution_type_list return sys_refcursor;

    function get_evolution_list return sys_refcursor;

    function get_currency_code_list return sys_refcursor;

    function get_cover_list(p_clm_ext_reference varchar2) return sys_refcursor;

    function get_interest_type_list return sys_refcursor;

    function get_court_list(p_court_enf_type varchar2, p_law_file_no varchar2 default null) return sys_refcursor;

    function get_reserve_date_list(p_law_file_no varchar2) return sys_refcursor;

    function get_bank_list return sys_refcursor;

    function get_agent_list(p_id number, p_ref_code varchar2, p_title varchar2) return sys_refcursor;

    function get_related_claim_list(p_clm_ext_reference varchar2) return sys_refcursor;

    function get_law_beginning_type return sys_refcursor;

    function get_party_role_list return sys_refcursor;

    function get_party_type_list return sys_refcursor;

    function get_finance_interest_type_list return sys_refcursor;

    function get_finance_court_type_list return sys_refcursor;

    function get_proxy_bulk(p_law_file_no in varchar2, p_part_id in number, p_unique_id in number) return law_proxy_tbl;

    function get_uyap_address_bulk(p_uyap_id in number, p_part_id in number, p_proxy_id in number) return law_uyap_address_tbl;

    function get_uyap_proxy_bulk(p_uyap_id in number, p_part_id in number) return law_uyap_proxy_tbl;

    function get_uyap_party_list(p_law_file_no varchar2, p_ticket_id number) return law_uyap_party_tbl;

    function get_authorization(p_law_file_no varchar2, p_object_name varchar2, p_object_detail varchar2) return law_authorization_typ;

    function get_law_expert_bulk(p_law_file_no in varchar2) return law_expert_expense_tbl;

    function get_expense_info_list(p_law_file_no in varchar2) return law_expense_info_typ;

    procedure save_expense_info_list(p_law_file_no in varchar2,
                                     p_rec in law_expense_info_typ,
                                     p_user_name in varchar2,
                                     p_court_revenue out number,
                                     p_process_results out customer.process_result_table,
                                     p_log_active number default 1);

    function get_assurance_letter_list(p_law_file_no in varchar2) return law_assurance_letter_tbl;

    procedure save_assurance_letter_list(p_law_file_no in varchar2,
                                         p_letter_rec in law_assurance_letter_typ,
                                         p_claim_list in law_assurance_claim_tbl,
                                         p_process_results out customer.process_result_table);

    procedure get_assurance_claim_list(p_law_file_no in varchar2,
                                       p_compensation_amount in number,
                                       p_list out law_assurance_claim_tbl,
                                       p_process_results out customer.process_result_table);

    procedure get_assurance_reserve_list(p_law_file_no in varchar2,
                                         p_claim in law_assurance_claim_typ,
                                         p_list out law_reserve_detail_tbl,
                                         p_process_results out customer.process_result_table);

    function get_reserve_policy_bulk(p_law_file_no varchar2, p_detail_no number default null) return law_reserve_policy_tbl;

    function get_reserve_detail_bulk(p_law_file_no varchar2, p_detail_no number default null, p_type varchar2) return law_reserve_detail_tbl;

    function get_credit_detail_bulk(p_law_file_no varchar2, p_detail_no number default null) return law_reserve_detail_tbl;

    function get_reserve_info(p_law_file_no varchar2, p_detail_no number default null, p_reserve_date date default null) return law_reserve_typ;

    procedure change_reserve_date(p_law_file_no in varchar2,
                                  p_detail_no in number,
                                  p_reserve_date in date,
                                  p_exceptional_flag out number,
                                  p_list out law_reserve_typ);

    procedure save_reserve_exception(p_law_file_no in varchar2,
                                     p_detail_no in number,
                                     p_reserve_date in date,
                                     p_list in law_reserve_detail_tbl,
                                     p_user_name in varchar2,
                                     p_process_results out customer.process_result_table);

    function get_passive_party_list(p_law_file_no varchar2) return law_passive_party_tbl;

    function get_money_movements_list(p_law_file_no varchar2) return law_money_movements_tbl;

    function get_money_movements_total_list(p_law_file_no varchar2) return law_money_movements_total_tbl;

    function get_money_movements_exp_list(p_law_file_no varchar2) return law_money_movements_exp_tbl;

    function get_law_notes_list(p_law_file_no varchar2, p_user_name varchar2) return law_note_tbl;

    procedure add_law_note(p_law_file_no in varchar2,
                           p_rec in law_note_typ,
                           p_process_results out customer.process_result_table);

    procedure modify_law_note(p_law_file_no in varchar2,
                              p_type in varchar2,
                              p_rec in law_note_typ,
                              p_process_results out customer.process_result_table);

    function get_law_uyap_list(p_law_file_no varchar2) return sys_refcursor;

    procedure add_law_uyap_id(p_law_file_no in varchar2,
                              p_uyap_id in number,
                              p_user_name in varchar2,
                              p_process_results out customer.process_result_table);

    procedure modify_law_uyap_id(p_law_file_no in varchar2,
                                 p_user_name in varchar2,
                                 p_type in varchar2,
                                 p_old_uyap_id in number,
                                 p_new_uyap_id in number,
                                 p_process_results out customer.process_result_table);

    function get_uyap_safahat_list(p_law_file_no varchar2) return sys_refcursor;
/*
    function get_detail_bre_info_bulk(p_law_file_no varchar2) return law_file_detail_bre_new_tbl;

    function get_law_file_bre_info(p_law_file_no varchar2) return law_file_bre_new_typ;
*/
    procedure do_action_authorization(p_law_file_no         in out varchar2,
                                      p_action_type         in varchar2,
                                      p_object_name         in varchar2,
                                      p_object_detail       in varchar2,
                                      p_rec                 in law_authorization_typ,
                                      p_lawfile_rec         in out law_file_all_typ,
                                      p_simple_questions    in out customer.simple_question_table,
                                      p_user_name           in varchar2,
                                      p_process_results out customer.process_result_table,
                                      p_description in out varchar2 ,
                                      p_status in out number );

    function get_court_details(p_law_file_no varchar2) return law_courts_tbl;

    function get_party_list(p_law_file_no varchar2) return law_party_tbl;

    function get_law_detail_list(p_law_file_no in varchar2) return law_base_detail_tbl;

    function get_law_base_info(p_law_file_no in varchar2) return law_base_typ;

    procedure get_lawfile(p_law_file_no varchar2,
                          p_user_name varchar2,
                          p_ticket_id number,
                          p_status out number,
                          p_description out varchar2,
                          p_law_file_rec out law_file_all_typ,
                          p_process_results out customer.process_result_table);

    procedure save_general_info(p_law_file_no in out varchar2,
                                p_user_name in varchar2,
                                p_rec in out law_general_info_typ,
                                p_process_results out customer.process_result_table,
                                p_type varchar2 default 'UPDATE');

    procedure save_court_details(p_law_file_no in varchar2,
                                 p_user_name in varchar2,
                                 p_list in law_courts_tbl,
                                 p_process_results out customer.process_result_table);

    procedure save_party_list(p_law_file_no in varchar2,
                              p_user_name in varchar2,
                              p_list in out law_party_tbl,
                              p_process_results out customer.process_result_table);

    procedure save_law_detail_list(p_law_file_no in varchar2,
                                   p_user_name in varchar2,
                                   p_list in out law_base_detail_tbl,
                                   p_base_rec in out law_base_typ,
                                   p_simple_questions in out customer.simple_question_table,
                                   p_process_results out customer.process_result_table,
                                   p_type varchar2 default 'UPDATE');

    procedure save_law_base_info(p_law_file_no in varchar2,
                                 p_user_name in varchar2,
                                 p_rec in out law_base_typ,
                                 p_process_results out customer.process_result_table);

    procedure save_lawfile(p_law_file_no in out varchar2,
                           p_user_name in varchar2,
                           p_rec in out law_file_all_typ,
                           p_simple_questions in out customer.simple_question_table,
                           p_process_results out customer.process_result_table,
                           p_description out varchar2,
                           p_status out number );

    procedure open_lawfile(p_law_file_no in varchar2,
                           p_user_name in varchar2,
                           p_rec out law_file_all_typ,
                           p_process_results out customer.process_result_table);

    procedure save_lawfile_log(p_law_file_no in varchar2,
                               p_process_results out customer.process_result_table);

    function get_law_log_no(p_law_file_no in varchar2) return number;

    function insert_law_generate_token(p_form_name varchar2, p_token varchar2, p_user_name varchar2, p_parameter varchar2) return number;

    procedure update_law_generate_token(p_form_name varchar2,
                                        p_token varchar2,
                                        p_return_value varchar2 default null);

    function get_lawfile_general_info(p_law_file_no in varchar2) return law_general_info_typ;

    function get_court_min_amount(p_law_file_no varchar2, p_date date default sysdate) return number;

    function get_law_finance_info_list(p_law_file_no varchar2 ) return sys_refcursor;

    procedure get_law_finance_info(p_law_file_no in varchar2,
                                   p_id number,
                                   p_finance_calc out law_finance_calc_typ,
                                   p_process_results out customer.process_result_table);


    procedure get_set_law_finance_info(p_law_file_no in varchar2,
                                       p_user_name in varchar2,
                                       p_finance_calc in out law_finance_calc_typ,
                                       p_process_results out customer.process_result_table);

    procedure get_default_party_list(p_law_file_no in varchar2, p_law_case_type in varchar2,
                                     p_law_file_type in varchar2, p_list out law_party_tbl, p_process_results out customer.process_result_table);

    procedure send_auth_approve (p_law_file_no        in     varchar2,
                                          p_source_table in varchar2,
                                          p_source_id_column in varchar2,
                                          p_source_id          in     varchar2,
                                          p_source_column          in     varchar2,
                                          p_new_value          in     varchar2,
                                          p_new_value_format   in     varchar2 default null,
                                          p_helper_value in varchar2,
                                          p_user               in     varchar2,
                                          p_description in varchar2,
                                          p_process_results out customer.process_result_table,
                                          p_num out number );

    procedure check_law_file_auth_approve (p_lawfile_no        in     varchar2,
                                              p_source_id          in     varchar2,
                                              p_source_table     in varchar2,
                                              p_source_column          in     varchar2,
                                              p_user               in     varchar2,
                                              p_old_rec in law_file_all_typ,
                                              p_new_rec in out law_file_all_typ,
                                              p_process_results in out customer.process_result_table );

    procedure auth_approve (p_authorization_id in number,
                            p_approver in varchar2,
                            p_approve_desc in varchar2 default null,
                            p_process_results in out customer.process_result_table );

    procedure approve_law_file_auth (
          p_authorization_id   in     number,
          p_approver           in     varchar2,
          p_rec in out law_file_all_typ,
          p_simple_questions in out customer.simple_question_table,
          p_process_results in out customer.process_result_table,
          p_description in out varchar2 ,
          p_status in out number );

    procedure auth_reject( p_authorization_id in number,
                                    p_approver in varchar2,
                                    p_reject_reason in varchar2,
                                    p_law_file_no in     varchar2,
                                    p_process_results in out customer.process_result_table );

    procedure auth_cancel( p_authorization_id in number,
                                    p_approver in varchar2,
                                    p_cancel_reason in varchar2,
                                    p_law_file_no        in     varchar2,
                                    p_process_results in out customer.process_result_table );

    function auth_check_base_record( p_source_ref_id in varchar2 ) return number;

    function is_auth_field( p_source_table in varchar2 ,p_source_column in varchar2 ) return number;

    function get_default_party_other_list(p_law_case_type in varchar2, p_law_file_type in varchar2) return sys_refcursor;

    function get_auth_line_desc( p_auth_id in number ) return varchar2;

    procedure interest_amount(p_amt NUMBER,p_type VARCHAR2,p_date1 DATE,p_date2 DATE,p_tutar OUT NUMBER);
end;
/

